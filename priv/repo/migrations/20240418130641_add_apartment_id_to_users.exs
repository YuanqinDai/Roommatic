defmodule RoommaticYd170.Repo.Migrations.AddApartmentIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :apartment_id, references(:apartments, on_delete: :nothing)
    end
  end
end
