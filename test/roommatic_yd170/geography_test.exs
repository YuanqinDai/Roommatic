defmodule RoommaticYd170.GeographyTest do
  use RoommaticYd170.DataCase

  alias RoommaticYd170.Geography

  describe "cities" do
    alias RoommaticYd170.Geography.City

    import RoommaticYd170.GeographyFixtures

    @invalid_attrs %{name: nil, country: nil}

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Geography.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Geography.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      valid_attrs = %{name: "some name", country: "some country"}

      assert {:ok, %City{} = city} = Geography.create_city(valid_attrs)
      assert city.name == "some name"
      assert city.country == "some country"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geography.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      update_attrs = %{name: "some updated name", country: "some updated country"}

      assert {:ok, %City{} = city} = Geography.update_city(city, update_attrs)
      assert city.name == "some updated name"
      assert city.country == "some updated country"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Geography.update_city(city, @invalid_attrs)
      assert city == Geography.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Geography.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Geography.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Geography.change_city(city)
    end
  end

  describe "neighborhoods" do
    alias RoommaticYd170.Geography.Neighborhood

    import RoommaticYd170.GeographyFixtures

    @invalid_attrs %{name: nil}

    test "list_neighborhoods/0 returns all neighborhoods" do
      neighborhood = neighborhood_fixture()
      assert Geography.list_neighborhoods() == [neighborhood]
    end

    test "get_neighborhood!/1 returns the neighborhood with given id" do
      neighborhood = neighborhood_fixture()
      assert Geography.get_neighborhood!(neighborhood.id) == neighborhood
    end

    test "create_neighborhood/1 with valid data creates a neighborhood" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Neighborhood{} = neighborhood} = Geography.create_neighborhood(valid_attrs)
      assert neighborhood.name == "some name"
    end

    test "create_neighborhood/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geography.create_neighborhood(@invalid_attrs)
    end

    test "update_neighborhood/2 with valid data updates the neighborhood" do
      neighborhood = neighborhood_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Neighborhood{} = neighborhood} = Geography.update_neighborhood(neighborhood, update_attrs)
      assert neighborhood.name == "some updated name"
    end

    test "update_neighborhood/2 with invalid data returns error changeset" do
      neighborhood = neighborhood_fixture()
      assert {:error, %Ecto.Changeset{}} = Geography.update_neighborhood(neighborhood, @invalid_attrs)
      assert neighborhood == Geography.get_neighborhood!(neighborhood.id)
    end

    test "delete_neighborhood/1 deletes the neighborhood" do
      neighborhood = neighborhood_fixture()
      assert {:ok, %Neighborhood{}} = Geography.delete_neighborhood(neighborhood)
      assert_raise Ecto.NoResultsError, fn -> Geography.get_neighborhood!(neighborhood.id) end
    end

    test "change_neighborhood/1 returns a neighborhood changeset" do
      neighborhood = neighborhood_fixture()
      assert %Ecto.Changeset{} = Geography.change_neighborhood(neighborhood)
    end
  end
end
