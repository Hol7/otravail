lib/oplace_web/live/admin/dashboard_live.ex

defmodule OplaceWeb.AdminDashboardLive do
  use OplaceWeb, :live_view
  alias Oplace.{Services, Jobs, Blog, Partners}

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:service_count, length(Services.list_services()))
     |> assign(:job_count, length(Jobs.list_job_offers()))
     |> assign(:submission_count, length(Jobs.list_submissions()))
     |> assign(:article_count, length(Blog.list_articles()))}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-6xl mx-auto">
        <h1 class="text-3xl font-bold mb-12">Dashboard Admin</h1>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 mb-12">
          <div class="border border-[#1E2A3B] p-6">
            <p class="text-gray-400 text-sm">Services</p>
            <p class="text-4xl font-bold text-[#3B82F6] mt-2"><%= @service_count %></p>
          </div>
          <div class="border border-[#1E2A3B] p-6">
            <p class="text-gray-400 text-sm">Offres d'emploi</p>
            <p class="text-4xl font-bold text-[#3B82F6] mt-2"><%= @job_count %></p>
          </div>
          <div class="border border-[#1E2A3B] p-6">
            <p class="text-gray-400 text-sm">Candidatures</p>
            <p class="text-4xl font-bold text-[#3B82F6] mt-2"><%= @submission_count %></p>
          </div>
          <div class="border border-[#1E2A3B] p-6">
            <p class="text-gray-400 text-sm">Articles</p>
            <p class="text-4xl font-bold text-[#3B82F6] mt-2"><%= @article_count %></p>
          </div>
        </div>
        <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
          <a href__="/admin/services" class="border border-[#1E2A3B] p-4 hover:border-[#3B82F6] transition text-center">Services</a>
          <a href__="/admin/jobs" class="border border-[#1E2A3B] p-4 hover:border-[#3B82F6] transition text-center">Offres</a>
          <a href__="/admin/submissions" class="border border-[#1E2A3B] p-4 hover:border-[#3B82F6] transition text-center">Candidatures</a>
          <a href__="/admin/blog" class="border border-[#1E2A3B] p-4 hover:border-[#3B82F6] transition text-center">Blog</a>
          <a href__="/admin/partners" class="border border-[#1E2A3B] p-4 hover:border-[#3B82F6] transition text-center">Partenaires</a>
        </div>
      </div>
    </div>
    """
  end
end
