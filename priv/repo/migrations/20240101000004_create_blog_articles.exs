defmodule Oplace.Repo.Migrations.CreateBlogArticles do
  use Ecto.Migration

  def change do
    create table(:blog_articles) do
      add :title, :string, null: false
      add :slug, :string
      add :content, :text
      add :excerpt, :string
      add :image_url, :string
      add :video_url, :string
      add :audio_url, :string
      add :external_link, :string
      add :status, :string, default: "draft"
      add :tags, {:array, :string}, default: []

      timestamps(type: :utc_datetime)
    end

    create unique_index(:blog_articles, [:slug])
  end
end
