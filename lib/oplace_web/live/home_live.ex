defmodule OplaceWeb.HomeLive do
  use OplaceWeb, :live_view

  alias Oplace.{Services, Jobs, Partners}

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:services, Services.list_active_services())
     |> assign(:jobs, Jobs.list_active_jobs() |> Enum.take(3))
     |> assign(:partners, Partners.list_active_partners())}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit">
      <!-- Hero -->
      <section class="px-6 py-32 max-w-6xl mx-auto text-center">
        <h1 class="text-5xl md:text-7xl font-bold mb-6 text-white">
          Des services de <span class="text-[#3B82F6]">confiance</span>
        </h1>
        <p class="text-xl text-gray-400 mb-10 max-w-2xl mx-auto">
          OPLACE connecte particuliers et entreprises avec des prestataires vérifiés au Bénin et en Afrique.
        </p>
        <div class="flex gap-4 justify-center">
          <a href__="/services" class="bg-[#3B82F6] text-white px-8 py-3 font-semibold hover:bg-blue-700 transition">
            Nos Services
          </a>
          <a href__="/jobs" class="border border-white text-white px-8 py-3 font-semibold hover:bg-white hover:text-[#0A0E1A] transition">
            Offres d'Emploi
          </a>
        </div>
      </section>

      <!-- Services -->
      <section class="px-6 py-20 max-w-6xl mx-auto">
        <h2 class="text-3xl font-bold mb-12 text-white">Nos Services</h2>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
          <%= for service <- @services do %>
            <div class="border border-[#1E2A3B] p-6 hover:border-[#3B82F6] transition cursor-pointer">
              <p class="font-semibold text-white"><%= service.title %></p>
              <p class="text-sm text-gray-400 mt-1"><%= service.description %></p>
            </div>
          <% end %>
        </div>
      </section>

      <!-- Jobs -->
      <section class="px-6 py-20 max-w-6xl mx-auto border-t border-[#1E2A3B]">
        <div class="flex justify-between items-center mb-12">
          <h2 class="text-3xl font-bold text-white">Offres Récentes</h2>
          <a href__="/jobs" class="text-[#3B82F6] hover:underline">Voir toutes →</a>
        </div>
        <div class="space-y-4">
          <%= for job <- @jobs do %>
            <a href__={"/jobs/#{job.id}"} class="block border border-[#1E2A3B] p-6 hover:border-[#3B82F6] transition">
              <div class="flex justify-between items-start">
                <div>
                  <h3 class="font-bold text-white text-lg"><%= job.title %></h3>
                  <p class="text-gray-400 mt-1"><%= job.location %></p>
                </div>
                <span class="text-sm border border-[#3B82F6] text-[#3B82F6] px-3 py-1">
                  <%= job.contract_type %>
                </span>
              </div>
            </a>
          <% end %>
        </div>
      </section>

      <!-- Partners -->
      <%= if @partners != [] do %>
        <section class="px-6 py-20 max-w-6xl mx-auto border-t border-[#1E2A3B]">
          <h2 class="text-3xl font-bold mb-12 text-white text-center">Nos Partenaires</h2>
          <div class="flex flex-wrap justify-center gap-8">
            <%= for partner <- @partners do %>
              <a href__={partner.website_url} target="_blank" class="opacity-60 hover:opacity-100 transition">
                <%= if partner.logo_url do %>
                  <img src={partner.logo_url} alt={partner.name} class="h-12 object-contain" />
                <% else %>
                  <span class="text-white font-bold"><%= partner.name %></span>
                <% end %>
              </a>
            <% end %>
          </div>
        </section>
      <% end %>
    </div>
    """
  end
end
