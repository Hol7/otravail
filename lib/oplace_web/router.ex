defmodule OplaceWeb.Router do
  use OplaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OplaceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CorsPlug, origin: "*"
  end

  scope "/", OplaceWeb do
    pipe_through :browser

    get "/", PageController, :home
  end


  scope "/", OplaceWeb do
    pipe_through :browser

    live "/", HomeLive
    live "/services", ServicesLive
    live "/jobs", JobsLive
    live "/jobs/:id", JobDetailLive
    live "/blog", BlogLive
    live "/blog/:slug", BlogArticleLive
    live "/about", AboutLive

    # Admin
    live "/admin", AdminDashboardLive
    live "/admin/services", AdminServicesLive
    live "/admin/jobs", AdminJobsLive
    live "/admin/submissions", AdminSubmissionsLive
    live "/admin/blog", AdminBlogLive
    live "/admin/partners", AdminPartnersLive
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug, schema: OplaceWeb.Schema

    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: OplaceWeb.Schema,
        interface: :simple
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", OplaceWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:oplace, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OplaceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
