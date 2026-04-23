defmodule OplaceWeb.JobsLive do
  use OplaceWeb, :live_view
  alias Oplace.Jobs

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :jobs, Jobs.list_active_jobs())}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-4xl mx-auto">
        <h1 class="text-4xl font-bold mb-12">Offres d'Emploi</h1>
        <div class="space-y-4">
          <%= for job <- @jobs do %>
            <a href__={"/jobs/#{job.id}"} class="block border border-[#1E2A3B] p-6 hover:border-[#3B82F6] transition">
              <div class="flex justify-between items-start">
                <div>
                  <h2 class="font-bold text-xl"><%= job.title %></h2>
                  <p class="text-gray-400 mt-1"><%= job.location %> · <%= job.contract_type %></p>
                  <p class="text-gray-500 mt-2 text-sm"><%= job.short_description %></p>
                </div>
                <div class="text-right">
                  <span class="text-xs text-gray-500"><%= job.views %> vues</span>
                </div>
              </div>
            </a>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
