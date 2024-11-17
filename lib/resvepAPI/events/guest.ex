defmodule ResvepAPI.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :event_id, :inserted_at, :updated_at]}
  schema "guests" do
    field :name, :string
    belongs_to :event, ResvepAPI.Event

    timestamps()
  end

  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:name, :event_id])
    |> validate_required([:name, :event_id])
  end
end
