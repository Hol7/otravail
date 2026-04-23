defmodule OplaceWeb.BlogArticleLive do
  use OplaceWeb, :live_view
  alias Oplace.Blog

  def mount(%{"slug" => slug}, _session, socket) do
    {:ok, assign(socket, :article, Blog.get_article_by_slug!(slug))}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-[#0A0E1A] text-white font-outfit px-6 py-20">
      <div class="max-w-3xl mx-auto">
        <a href__="/blog" class="text-[#3B82F6] hover:underline mb-8 block">← Retour au blog</a>
        <h1 class="text-4xl font-bold mb-4"><%= @article.title %></h1>
        <p class="text-gray-400 mb-8"><%= @article.excerpt %></p>
        <div class="text-gray-300 prose prose-invert max-w-none">
          <%= raw(@article.content) %>
        </div>
      </div>
    </div>
    """
  end
end
