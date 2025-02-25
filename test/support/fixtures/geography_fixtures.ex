defmodule RoommaticYd170.GeographyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RoommaticYd170.Geography` context.
  """

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        country: "some country",
        name: "some name"
      })
      |> RoommaticYd170.Geography.create_city()

    city
  end

  @doc """
  Generate a neighborhood.
  """
  def neighborhood_fixture(attrs \\ %{}) do
    {:ok, neighborhood} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> RoommaticYd170.Geography.create_neighborhood()

    neighborhood
  end
end
