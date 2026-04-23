defmodule OplaceWeb.AboutLive do
  use OplaceWeb, :live_view

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-3xl mx-auto">
        <h1 class="text-4xl font-bold mb-8">À propos d'OPLACE</h1>
        <p class="text-gray-300 text-lg leading-relaxed mb-6">
          OPLACE est une plateforme digitale dédiée à la mise en relation entre
          particuliers, entreprises et prestataires de services au Bénin et en Afrique.
        </p>
        <p class="text-gray-300 text-lg leading-relaxed">
          Notre mission : rendre les services professionnels accessibles, fiables et transparents
          pour tous, grâce à la technologie et à la confiance.
        </p>
      </div>
    </div>
    """
  end
end
