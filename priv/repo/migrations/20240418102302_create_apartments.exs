defmodule RoommaticYd170.Repo.Migrations.CreateApartments do
  use Ecto.Migration

  def change do
    create table(:apartments) do
      add :street_address, :string
      add :bedrooms, :integer
      add :rent, :decimal
      add :notes, :text
      add :city_id, references(:cities, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:apartments, [:city_id])
  end
end
