defmodule Oplace.Services do
  import Ecto.Query
  alias Oplace.Repo
  alias Oplace.Services.Service

  def list_services, do: Repo.all(from s in Service, order_by: [asc: s.inserted_at])
  def list_active_services, do: Repo.all(from s in Service, where: s.is_active == true, order_by: [asc: s.title])
  def get_service!(id), do: Repo.get!(Service, id)
  def create_service(attrs), do: %Service{} |> Service.changeset(attrs) |> Repo.insert()
  def update_service(%Service{} = s, attrs), do: s |> Service.changeset(attrs) |> Repo.update()
  def delete_service(%Service{} = s), do: Repo.delete(s)
end
