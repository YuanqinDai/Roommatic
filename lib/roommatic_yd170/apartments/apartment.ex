defmodule RoommaticYd170.Apartments.Apartment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apartments" do
    field :street_address, :string
    field :bedrooms, :integer
    field :rent, :decimal
    field :notes, :string
    belongs_to :city, RoommaticYd170.Geography.City
    has_many :residents, RoommaticYd170.Apartments.Resident

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(apartment, attrs) do
    apartment
    |> cast(attrs, [:street_address, :bedrooms, :rent, :notes, :city_id])
    |> validate_required([:street_address, :bedrooms, :rent, :city_id])
  end

  def resident?(apartment, resident) do
    resident.apartment_id == apartment.id
  end
end
