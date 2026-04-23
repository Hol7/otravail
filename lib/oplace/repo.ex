defmodule Oplace.Repo do
  use Ecto.Repo,
    otp_app: :oplace,
    adapter: Ecto.Adapters.Postgres
end
