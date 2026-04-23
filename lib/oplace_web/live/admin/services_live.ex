defmodule OplaceWeb.AdminServicesLive do
  use OplaceWeb, :live_view
  alias Oplace.Services
  alias Oplace.Services.Service

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:services, Services.list_services())
     |> assign(:editing, nil)
     |> assign(:form, to_form(Service.changeset(%Service{}, %{})))}
  end

  def handle_event("new", _, socket) do
    {:noreply, assign(socket, :editing, :new)}
  end

  def handle_event("edit", %{"id" => id}, socket) do
    service = Services.get_service!(id)
    {:noreply,
     socket
     |> assign(:editing, id)
     |> assign(:form, to_form(Service.changeset(service, %{})))}
  end

  def handle_event("save", %{"service" => params}, socket) do
    result =
      if socket.assigns.editing == :new do
        Services.create_service(params)
      else
        service = Services.get_service!(socket.assigns.editing)
        Services.update_service(service, params)
      end

    case result do
      {:ok, _} ->
        {:noreply,
         socket
         |> assign(:services, Services.list_services())
         |> assign(:editing, nil)
         |> put_flash(:info, "Sauvegardé!")}
      {:error, cs} ->
        {:noreply, assign(socket, :form, to_form(cs))}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    service = Services.get_service!(id)
    Services.delete_service(service)
    {:noreply, assign(socket, :services, Services.list_services())}
  end

  def handle_event("cancel", _, socket) do
    {:noreply, assign(socket, :editing, nil)}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-4xl mx-auto">
        <div class="flex justify-between items-center mb-8">
          <h1 class="text-3xl font-bold">Services</h1>
          <button phx-click="new" class="bg-[#3B82F6] px-4 py-2 font-semibold hover:bg-blue-700 transition">
            + Nouveau
          </button>
        </div>

        <%= if @editing do %>
          <.form for={@form} phx-submit="save" class="border border-[#1E2A3B] p-6 mb-8 space-y-4">
            <div>
              <label class="block text-sm text-gray-400 mb-1">Titre</label>
              <.input field={@form[:title]} class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none" />
            </div>
            <div>
              <label class="block text-sm text-gray-400 mb-1">Description</label>
              <.input type="textarea" field={@form[:description]} class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none" />
            </div>
            <div class="flex gap-4">
              <button type="submit" class="bg-[#3B82F6] px-6 py-2 font-semibold hover:bg-blue-700 transition">Sauvegarder</button>
              <button type="button" phx-click="cancel" class="border border-[#1E2A3B] px-6 py-2 hover:border-white transition">Annuler</button>
            </div>
          </.form>
        <% end %>

        <div class="space-y-3">
          <%= for service <- @services do %>
            <div class="border border-[#1E2A3B] p-4 flex justify-between items-center">
              <div>
                <p class="font-semibold"><%= service.title %></p>
                <p class="text-sm text-gray-400"><%= service.description %></p>
              </div>
              <div class="flex gap-2">
                <button phx-click="edit" phx-value-id={service.id}
                  class="text-[#3B82F6] hover:underline text-sm">Éditer</button>
                <button phx-click="delete" phx-value-id={service.id}
                  data-confirm="Supprimer ce service?"
                  class="text-red-400 hover:underline text-sm">Supprimer</button>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
