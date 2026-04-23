defmodule Oplace.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :title, :string, null: false
      add :description, :text
      add :icon_url, :string
      add :is_active, :boolean, default: true

      timestamps(type: :utc_datetime)
    end
  end
end
