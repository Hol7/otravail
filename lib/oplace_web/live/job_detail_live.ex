defmodule OplaceWeb.JobDetailLive do
  use OplaceWeb, :live_view
  alias Oplace.Jobs

  def mount(%{"id" => id}, _session, socket) do
    job = Jobs.get_job_offer!(id)
    Jobs.increment_views(job)
    job = Jobs.get_job_offer!(id)

    {:ok,
     socket
     |> assign(:job, job)
     |> assign(:form, to_form(%{}))}
  end

  def handle_event("submit_application", params, socket) do
    attrs = Map.merge(params, %{
      "job_offer_id" => socket.assigns.job.id,
      "job_title" => socket.assigns.job.title
    })

    case Jobs.create_submission(attrs) do
      {:ok, _} ->
        {:noreply, socket |> put_flash(:info, "Candidature envoyée avec succès!")}
      {:error, _} ->
        {:noreply, socket |> put_flash(:error, "Erreur lors de l'envoi.")}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-3xl mx-auto">
        <a href__="/jobs" class="text-[#3B82F6] hover:underline mb-8 block">← Retour aux offres</a>

        <div class="border border-[#1E2A3B] p-8 mb-8">
          <div class="flex justify-between items-start mb-6">
            <div>
              <h1 class="text-3xl font-bold"><%= @job.title %></h1>
              <p class="text-gray-400 mt-2"><%= @job.location %></p>
            </div>
            <span class="border border-[#3B82F6] text-[#3B82F6] px-3 py-1 text-sm">
              <%= @job.contract_type %>
            </span>
          </div>
          <div class="text-gray-300 prose prose-invert max-w-none">
            <%= raw(@job.description) %>
          </div>
        </div>

        <!-- Application Form -->
        <div class="border border-[#1E2A3B] p-8">
          <h2 class="text-2xl font-bold mb-6">Postuler</h2>
          <form phx-submit="submit_application" class="space-y-4">
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-sm text-gray-400 mb-1">Prénom *</label>
                <input name="first_name" required
                  class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none" />
              </div>
              <div>
                <label class="block text-sm text-gray-400 mb-1">Nom *</label>
                <input name="last_name" required
                  class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none" />
              </div>
            </div>
            <div>
              <label class="block text-sm text-gray-400 mb-1">Téléphone *</label>
              <input name="phone" required
                class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none" />
            </div>
            <div>
              <label class="block text-sm text-gray-400 mb-1">Email</label>
              <input name="email" type="email"
                class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none" />
            </div>
            <div>
              <label class="block text-sm text-gray-400 mb-1">Motivation *</label>
              <textarea name="motivation" required rows="5"
                class="w-full bg-transparent border border-[#1E2A3B] p-3 text-white focus:border-[#3B82F6] outline-none"></textarea>
            </div>
            <button type="submit"
              class="w-full bg-[#3B82F6] text-white py-3 font-semibold hover:bg-blue-700 transition">
              Envoyer ma candidature
            </button>
          </form>
        </div>
      </div>
    </div>
    """
  end
end
