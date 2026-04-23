defmodule Oplace.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blog_articles" do
    field :title, :string
    field :slug, :string
    field :content, :string
    field :excerpt, :string
    field :image_url, :string
    field :video_url, :string
    field :audio_url, :string
    field :external_link, :string
    field :status, :string, default: "draft"
    field :tags, {:array, :string}, default: []

    timestamps(type: :utc_datetime)
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :slug, :content, :excerpt, :image_url, :video_url,
                    :audio_url, :external_link, :status, :tags])
    |> validate_required([:title])
    |> unique_constraint(:slug)
    |> maybe_generate_slug()
  end

  defp maybe_generate_slug(%Ecto.Changeset{valid?: true, changes: %{title: title}} = cs) do
    if get_field(cs, :slug) in [nil, ""] do
      put_change(cs, :slug, slugify(title))
    else
      cs
    end
  end
  defp maybe_generate_slug(cs), do: cs

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/\s+/, "-")
    |> String.trim("-")
  end
end
