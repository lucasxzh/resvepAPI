defmodule ResvepAPI.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, null: false
      add :limit, :integer

      timestamps()
    end
  end
end
