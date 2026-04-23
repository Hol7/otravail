defmodule Oplace.Repo.Migrations.CreateJobSubmissions do
  use Ecto.Migration

  def change do
    create table(:job_submissions) do
      add :job_offer_id, references(:job_offers, on_delete: :nilify_all)
      add :job_title, :string
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :phone, :string, null: false
      add :email, :string
      add :motivation, :text, null: false
      add :cv_url, :string
      add :status, :string, default: "new"

      timestamps(type: :utc_datetime)
    end

    create index(:job_submissions, [:job_offer_id])
  end
end
