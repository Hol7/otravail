defmodule Oplace.Jobs.JobOffer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_offers" do
    field :title, :string
    field :description, :string
    field :short_description, :string
    field :status, :string, default: "active"
    field :contract_type, :string
    field :job_type, :string, default: "recurrent"
    field :location, :string
    field :deadline, :date
    field :experience_level, :string
    field :image_url, :string
    field :views, :integer, default: 0
    field :service_category, :string

    has_many :submissions, Oplace.Jobs.JobSubmission

    timestamps(type: :utc_datetime)
  end

  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :description, :short_description, :status, :contract_type,
                    :job_type, :location, :deadline, :experience_level, :image_url,
                    :views, :service_category])
    |> validate_required([:title])
    |> validate_inclusion(:status, ["active", "closed", "draft"])
    |> validate_inclusion(:contract_type, ["CDI", "CDD", "Stage", "Freelance", "Temps partiel"])
  end
end
