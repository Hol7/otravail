defmodule Oplace.Blog do
  import Ecto.Query
  alias Oplace.Repo
  alias Oplace.Blog.Article

  def list_articles, do: Repo.all(from a in Article, order_by: [desc: a.inserted_at])
  def list_published, do: Repo.all(from a in Article, where: a.status == "published", order_by: [desc: a.inserted_at])
  def get_article!(id), do: Repo.get!(Article, id)
  def get_article_by_slug!(slug), do: Repo.get_by!(Article, slug: slug)
  def create_article(attrs), do: %Article{} |> Article.changeset(attrs) |> Repo.insert()
  def update_article(%Article{} = a, attrs), do: a |> Article.changeset(attrs) |> Repo.update()
  def delete_article(%Article{} = a), do: Repo.delete(a)
end
