defmodule RoommaticYd170.Geography do
  @moduledoc """
  The Geography context.
  """

  import Ecto.Query, warn: false
  alias RoommaticYd170.Repo

  alias RoommaticYd170.Geography.City

  @doc """
  Returns the list of cities.

  ## Examples

      iex> list_cities()
      [%City{}, ...]

  """
  def list_cities do
    Repo.all(City)
  end

  @doc """
  Gets a single city.

  Raises `Ecto.NoResultsError` if the City does not exist.

  ## Examples

      iex> get_city!(123)
      %City{}

      iex> get_city!(456)
      ** (Ecto.NoResultsError)

  """
  def get_city!(id), do: Repo.get!(City, id)

  @doc """
  Creates a city.

  ## Examples

      iex> create_city(%{field: value})
      {:ok, %City{}}

      iex> create_city(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_city(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a city.

  ## Examples

      iex> update_city(city, %{field: new_value})
      {:ok, %City{}}

      iex> update_city(city, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_city(%City{} = city, attrs) do
    city
    |> City.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a city.

  ## Examples

      iex> delete_city(city)
      {:ok, %City{}}

      iex> delete_city(city)
      {:error, %Ecto.Changeset{}}

  """
  def delete_city(%City{} = city) do
    Repo.delete(city)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking city changes.

  ## Examples

      iex> change_city(city)
      %Ecto.Changeset{data: %City{}}

  """
  def change_city(%City{} = city, attrs \\ %{}) do
    City.changeset(city, attrs)
  end

  alias RoommaticYd170.Geography.Neighborhood

  @doc """
  Returns the list of neighborhoods.

  ## Examples

      iex> list_neighborhoods()
      [%Neighborhood{}, ...]

  """
  def list_neighborhoods do
    Repo.all(Neighborhood)
  end

  @doc """
  Gets a single neighborhood.

  Raises `Ecto.NoResultsError` if the Neighborhood does not exist.

  ## Examples

      iex> get_neighborhood!(123)
      %Neighborhood{}

      iex> get_neighborhood!(456)
      ** (Ecto.NoResultsError)

  """
  def get_neighborhood!(id), do: Repo.get!(Neighborhood, id)

  @doc """
  Creates a neighborhood.

  ## Examples

      iex> create_neighborhood(%{field: value})
      {:ok, %Neighborhood{}}

      iex> create_neighborhood(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_neighborhood(attrs \\ %{}) do
    %Neighborhood{}
    |> Neighborhood.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a neighborhood.

  ## Examples

      iex> update_neighborhood(neighborhood, %{field: new_value})
      {:ok, %Neighborhood{}}

      iex> update_neighborhood(neighborhood, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_neighborhood(%Neighborhood{} = neighborhood, attrs) do
    neighborhood
    |> Neighborhood.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a neighborhood.

  ## Examples

      iex> delete_neighborhood(neighborhood)
      {:ok, %Neighborhood{}}

      iex> delete_neighborhood(neighborhood)
      {:error, %Ecto.Changeset{}}

  """
  def delete_neighborhood(%Neighborhood{} = neighborhood) do
    Repo.delete(neighborhood)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking neighborhood changes.

  ## Examples

      iex> change_neighborhood(neighborhood)
      %Ecto.Changeset{data: %Neighborhood{}}

  """
  def change_neighborhood(%Neighborhood{} = neighborhood, attrs \\ %{}) do
    Neighborhood.changeset(neighborhood, attrs)
  end
end
