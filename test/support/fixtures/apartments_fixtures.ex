defmodule RoommaticYd170.ApartmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RoommaticYd170.Apartments` context.
  """

  @doc """
  Generate a apartment.
  """
  def apartment_fixture(attrs \\ %{}) do
    {:ok, apartment} =
      attrs
      |> Enum.into(%{
        bedrooms: 42,
        notes: "some notes",
        rent: "120.5",
        street_address: "some street_address"
      })
      |> RoommaticYd170.Apartments.create_apartment()

    apartment
  end
end
