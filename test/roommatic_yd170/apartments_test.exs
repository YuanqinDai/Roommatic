defmodule RoommaticYd170.ApartmentsTest do
  use RoommaticYd170.DataCase

  alias RoommaticYd170.Apartments

  describe "apartments" do
    alias RoommaticYd170.Apartments.Apartment

    import RoommaticYd170.ApartmentsFixtures

    @invalid_attrs %{street_address: nil, bedrooms: nil, rent: nil, notes: nil}

    test "list_apartments/0 returns all apartments" do
      apartment = apartment_fixture()
      assert Apartments.list_apartments() == [apartment]
    end

    test "get_apartment!/1 returns the apartment with given id" do
      apartment = apartment_fixture()
      assert Apartments.get_apartment!(apartment.id) == apartment
    end

    test "create_apartment/1 with valid data creates a apartment" do
      valid_attrs = %{street_address: "some street_address", bedrooms: 42, rent: "120.5", notes: "some notes"}

      assert {:ok, %Apartment{} = apartment} = Apartments.create_apartment(valid_attrs)
      assert apartment.street_address == "some street_address"
      assert apartment.bedrooms == 42
      assert apartment.rent == Decimal.new("120.5")
      assert apartment.notes == "some notes"
    end

    test "create_apartment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apartments.create_apartment(@invalid_attrs)
    end

    test "update_apartment/2 with valid data updates the apartment" do
      apartment = apartment_fixture()
      update_attrs = %{street_address: "some updated street_address", bedrooms: 43, rent: "456.7", notes: "some updated notes"}

      assert {:ok, %Apartment{} = apartment} = Apartments.update_apartment(apartment, update_attrs)
      assert apartment.street_address == "some updated street_address"
      assert apartment.bedrooms == 43
      assert apartment.rent == Decimal.new("456.7")
      assert apartment.notes == "some updated notes"
    end

    test "update_apartment/2 with invalid data returns error changeset" do
      apartment = apartment_fixture()
      assert {:error, %Ecto.Changeset{}} = Apartments.update_apartment(apartment, @invalid_attrs)
      assert apartment == Apartments.get_apartment!(apartment.id)
    end

    test "delete_apartment/1 deletes the apartment" do
      apartment = apartment_fixture()
      assert {:ok, %Apartment{}} = Apartments.delete_apartment(apartment)
      assert_raise Ecto.NoResultsError, fn -> Apartments.get_apartment!(apartment.id) end
    end

    test "change_apartment/1 returns a apartment changeset" do
      apartment = apartment_fixture()
      assert %Ecto.Changeset{} = Apartments.change_apartment(apartment)
    end
  end
end
