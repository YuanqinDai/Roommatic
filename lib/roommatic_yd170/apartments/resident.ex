defmodule RoommaticYd170.Apartments.Resident do
  use Ecto.Schema
  import Ecto.Changeset

  #Defining the schema for the "users" table in the database
  #It has two relevant fields to this context: email and apartment_id
  schema "users" do
    field :email, :string
    #Signifies that each user belongs to a residence, established by the foreign key
    belongs_to :residence, RoommaticYd170.Apartments.Apartment, foreign_key: :apartment_id, on_replace: :update
  end

  def occupy_changeset(resident, apartment) do
    resident
    |> change(residence: apartment)
  end

  def vacate_changeset(resident) do
    resident
    |> change(residence: nil)
  end
end
