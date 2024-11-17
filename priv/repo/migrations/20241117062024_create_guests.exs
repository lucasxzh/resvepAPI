defmodule ResvepAPI.Repo.Migrations.CreateGuests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :name, :string, null: false
      add :event_id, references(:events, on_delete: :delete_all)

      timestamps()
    end

    create index(:guests, [:event_id])
  end
end
