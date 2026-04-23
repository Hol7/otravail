defmodule Oplace.Partners do
  import Ecto.Query
  alias Oplace.Repo
  alias Oplace.Partners.Partner

  def list_partners, do: Repo.all(from p in Partner, order_by: [asc: p.name])
  def list_active_partners, do: Repo.all(from p in Partner, where: p.is_active == true)
  def get_partner!(id), do: Repo.get!(Partner, id)
  def create_partner(attrs), do: %Partner{} |> Partner.changeset(attrs) |> Repo.insert()
  def update_partner(%Partner{} = p, attrs), do: p |> Partner.changeset(attrs) |> Repo.update()
  def delete_partner(%Partner{} = p), do: Repo.delete(p)
end
