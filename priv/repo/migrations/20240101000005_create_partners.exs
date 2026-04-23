defmodule Oplace.Repo.Migrations.CreatePartners do
  use Ecto.Migration

  def change do
    create table(:partners) do
      add :name, :string, null: false
      add :logo_url, :string
      add :website_url, :string
      add :is_active, :boolean, default: true

      timestamps(type: :utc_datetime)
    end
  end
end
