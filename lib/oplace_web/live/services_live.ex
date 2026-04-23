defmodule OplaceWeb.ServicesLive do
  use OplaceWeb, :live_view
  alias Oplace.Services

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :services, Services.list_active_services())}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-6xl mx-auto">
        <h1 class="text-4xl font-bold mb-12">Nos Services</h1>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <%= for service <- @services do %>
            <div class="border border-[#1E2A3B] p-8 hover:border-[#3B82F6] transition">
              <h2 class="text-xl font-bold mb-3"><%= service.title %></h2>
              <p class="text-gray-400"><%= service.description %></p>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
