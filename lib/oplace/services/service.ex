defmodule Oplace.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :title, :string
    field :description, :string
    field :icon_url, :string
    field :is_active, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title, :description, :icon_url, :is_active])
    |> validate_required([:title])
  end
end
