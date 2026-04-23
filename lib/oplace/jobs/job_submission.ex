defmodule Oplace.Jobs.JobSubmission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_submissions" do
    field :job_title, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :email, :string
    field :motivation, :string
    field :cv_url, :string
    field :status, :string, default: "new"

    belongs_to :job_offer, Oplace.Jobs.JobOffer

    timestamps(type: :utc_datetime)
  end

  def changeset(sub, attrs) do
    sub
    |> cast(attrs, [:job_offer_id, :job_title, :first_name, :last_name, :phone,
                    :email, :motivation, :cv_url, :status])
    |> validate_required([:first_name, :last_name, :phone, :motivation])
    |> validate_format(:email, ~r/@/)
  end
end
