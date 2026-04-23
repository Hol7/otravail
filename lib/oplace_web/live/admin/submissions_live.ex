defmodule OplaceWeb.AdminSubmissionsLive do
  use OplaceWeb, :live_view
  alias Oplace.Jobs

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :submissions, Jobs.list_submissions())}
  end

  def handle_event("update_status", %{"id" => id, "status" => status}, socket) do
    sub = Jobs.get_submission!(id)
    Jobs.update_submission(sub, %{status: status})
    {:noreply, assign(socket, :submissions, Jobs.list_submissions())}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-6xl mx-auto">
        <h1 class="text-3xl font-bold mb-8">Candidatures</h1>
        <div class="space-y-4">
          <%= for sub <- @submissions do %>
            <div class="border border-[#1E2A3B] p-6">
              <div class="flex justify-between items-start">
                <div>
                  <p class="font-bold"><%= sub.first_name %> <%= sub.last_name %></p>
                  <p class="text-gray-400 text-sm"><%= sub.job_title %></p>
                  <p class="text-gray-500 text-sm"><%= sub.phone %> · <%= sub.email %></p>
                  <p class="text-gray-300 mt-2 text-sm"><%= sub.motivation %></p>
                </div>
                <div class="flex flex-col gap-2 items-end">
                  <span class={"text-xs px-2 py-1 #{status_color(sub.status)}"}>
                    <%= sub.status %>
                  </span>
                  <select phx-change="update_status" phx-value-id={sub.id}
                    class="bg-[#0A0E1A] border border-[#1E2A3B] text-white text-sm p-1">
                    <option value="new" selected={sub.status == "new"}>Nouveau</option>
                    <option value="reviewed" selected={sub.status == "reviewed"}>Vu</option>
                    <option value="contacted" selected={sub.status == "contacted"}>Contacté</option>
                    <option value="rejected" selected={sub.status == "rejected"}>Rejeté</option>
                  </select>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  defp status_color("new"), do: "border border-blue-400 text-blue-400"
  defp status_color("reviewed"), do: "border border-yellow-400 text-yellow-400"
  defp status_color("contacted"), do: "border border-green-400 text-green-400"
  defp status_color("rejected"), do: "border border-red-400 text-red-400"
  defp status_color(_), do: "border border-gray-400 text-gray-400"
end
