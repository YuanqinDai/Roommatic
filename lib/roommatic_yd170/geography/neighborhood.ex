defmodule RoommaticYd170.Geography.Neighborhood do
  use Ecto.Schema
  import Ecto.Changeset

  schema "neighborhoods" do
    field :name, :string
    field :city_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(neighborhood, attrs) do
    neighborhood
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
