defmodule Oplace.Repo.Migrations.CreateJobOffers do
  use Ecto.Migration

  def change do
    create table(:job_offers) do
      add :title, :string, null: false
      add :description, :text
      add :short_description, :string
      add :status, :string, default: "active"
      add :contract_type, :string
      add :job_type, :string, default: "recurrent"
      add :location, :string
      add :deadline, :date
      add :experience_level, :string
      add :image_url, :string
      add :views, :integer, default: 0
      add :service_category, :string

      timestamps(type: :utc_datetime)
    end
  end
end
