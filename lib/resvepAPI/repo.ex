defmodule ResvepAPI.Repo do
  use Ecto.Repo,
    otp_app: :resvepAPI,
    adapter: Ecto.Adapters.Postgres
end
