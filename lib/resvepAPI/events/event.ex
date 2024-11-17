defmodule ResvepAPI.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :limit, :guests, :inserted_at, :updated_at]}
  schema "events" do
    field :name, :string
    field :limit, :integer
    has_many :guests, ResvepAPI.Guest, on_replace: :delete

    timestamps()
  end

  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :limit])
    |> validate_required([:name])
    |> put_assoc(:guests, [])
  end
end
