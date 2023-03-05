defmodule Dndstore.Repo do
  use Ecto.Repo,
    otp_app: :dndstore,
    adapter: Ecto.Adapters.Postgres
end
