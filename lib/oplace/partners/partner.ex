defmodule Oplace.Partners.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :name, :string
    field :logo_url, :string
    field :website_url, :string
    field :is_active, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name, :logo_url, :website_url, :is_active])
    |> validate_required([:name])
  end
end
