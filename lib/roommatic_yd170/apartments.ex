defmodule RoommaticYd170.Apartments do
  @moduledoc """
  The Apartments context.
  """

  import Ecto.Query, warn: false
  alias RoommaticYd170.Repo
  alias RoommaticYd170.Apartments
  alias RoommaticYd170.Apartments.{Apartment, Resident}

  def subscribe(apartment) do
    Phoenix.PubSub.subscribe(RoommaticYd170.PubSub,"apartments:#{apartment.id}")
  end

  def broadcast({:error, _changeset} = error, _tag), do: error
  def broadcast(apartment, tag) do
    Phoenix.PubSub.broadcast(
      RoommaticYd170.PubSub,
      "apartments:#{apartment.id}",
      {tag, apartment}
    )
  end
  @doc """
  Returns the list of apartments.

  ## Examples

      iex> list_apartments()
      [%Apartment{}, ...]

  """
  def list_apartments do
    Repo.all(Apartment)
  end

  @doc """
  Gets a single apartment.

  Raises `Ecto.NoResultsError` if the Apartment does not exist.

  ## Examples

      iex> get_apartment!(123)
      %Apartment{}

      iex> get_apartment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_apartment!(id), do: Repo.get!(Apartment, id)

  @doc """
  Creates a apartment.

  ## Examples

      iex> create_apartment(%{field: value})
      {:ok, %Apartment{}}

      iex> create_apartment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_apartment(attrs \\ %{}) do
    %Apartment{}
    |> Apartment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a apartment.

  ## Examples

      iex> update_apartment(apartment, %{field: new_value})
      {:ok, %Apartment{}}

      iex> update_apartment(apartment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_apartment(%Apartment{} = apartment, attrs) do
    apartment
    |> Apartment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a apartment.

  ## Examples

      iex> delete_apartment(apartment)
      {:ok, %Apartment{}}

      iex> delete_apartment(apartment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_apartment(%Apartment{} = apartment) do
    Repo.delete(apartment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking apartment changes.

  ## Examples

      iex> change_apartment(apartment)
      %Ecto.Changeset{data: %Apartment{}}

  """
  def change_apartment(%Apartment{} = apartment, attrs \\ %{}) do
    Apartment.changeset(apartment, attrs)
  end


  def get_resident!(id) do
    Resident
    |> preload(:residence)
    |> Repo.get!(id)
  end

  def get_apartment_with_residents!(id) do
    Apartment
    |> preload(:residents)
    |> Repo.get!(id)
  end

  def resident?(apartment, resident) do
    Apartment.resident?(apartment, resident)
  end

  def move_resident_in(apartment, resident) do
    previous_apartment_id = resident.apartment_id
    with {:ok, resident} <- resident
      |> Resident.occupy_changeset(apartment)
      |> Repo.update()
    do
      [apartment.id, previous_apartment_id]
      |> Enum.filter(fn id -> !is_nil(id) end)
      |> Enum.map(fn id -> broadcast(get_apartment_with_residents!(id), :residents_updated) end)
      {:ok, resident}
    else
      error -> error
    end
  end

  @spec move_resident_out(any(), any()) :: any()
  def move_resident_out(apartment, resident) do
    with{:ok, resident} <- resident
      |> Resident.vacate_changeset()
      |> Repo.update()
    do
      broadcast(get_apartment_with_residents!(apartment.id), :residents_updated)
      {:ok, resident}
    else
      error -> error
    end
  end

end
