defmodule OplaceWeb.BlogLive do
  use OplaceWeb, :live_view
  alias Oplace.Blog

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :articles, Blog.list_published())}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold mb-12">Blog</h1>
        <div class="space-y-6">
          <%= for article <- @articles do %>
            <a href__={"/blog/#{article.slug}"} class="block border border-[#1E2A3B] p-6 hover:border-[#3B82F6] transition">
              <h2 class="text-xl font-bold mb-2"><%= article.title %></h2>
              <p class="text-gray-400"><%= article.excerpt %></p>
              <div class="flex gap-2 mt-3">
                <%= for tag <- article.tags do %>
                  <span class="text-xs border border-[#3B82F6] text-[#3B82F6] px-2 py-0.5"><%= tag %></span>
                <% end %>
              </div>
            </a>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
