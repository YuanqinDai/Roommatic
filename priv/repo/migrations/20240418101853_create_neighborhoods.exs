defmodule RoommaticYd170.Repo.Migrations.CreateNeighborhoods do
  use Ecto.Migration

  def change do
    create table(:neighborhoods) do
      add :name, :string
      add :city_id, references(:cities, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:neighborhoods, [:city_id])
  end
end
