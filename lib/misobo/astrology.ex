defmodule Misobo.Astrology do
  @moduledoc """
  The Astrology context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Astrology.Horoscorpe

  @doc """
  Returns the list of horoscopes.

  ## Examples

      iex> list_horoscopes()
      [%Horoscorpe{}, ...]

  """
  def list_horoscopes do
    Repo.all(Horoscorpe)
  end

  @doc """
  Gets a single horoscorpe.

  Raises `Ecto.NoResultsError` if the Horoscorpe does not exist.

  ## Examples

      iex> get_horoscorpe!(123)
      %Horoscorpe{}

      iex> get_horoscorpe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_horoscorpe!(id), do: Repo.get!(Horoscorpe, id)

  @doc """
  Creates a horoscorpe.

  ## Examples

      iex> create_horoscorpe(%{field: value})
      {:ok, %Horoscorpe{}}

      iex> create_horoscorpe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_horoscorpe(attrs \\ %{}) do
    %Horoscorpe{}
    |> Horoscorpe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a horoscorpe.

  ## Examples

      iex> update_horoscorpe(horoscorpe, %{field: new_value})
      {:ok, %Horoscorpe{}}

      iex> update_horoscorpe(horoscorpe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_horoscorpe(%Horoscorpe{} = horoscorpe, attrs) do
    horoscorpe
    |> Horoscorpe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a horoscorpe.

  ## Examples

      iex> delete_horoscorpe(horoscorpe)
      {:ok, %Horoscorpe{}}

      iex> delete_horoscorpe(horoscorpe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_horoscorpe(%Horoscorpe{} = horoscorpe) do
    Repo.delete(horoscorpe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking horoscorpe changes.

  ## Examples

      iex> change_horoscorpe(horoscorpe)
      %Ecto.Changeset{data: %Horoscorpe{}}

  """
  def change_horoscorpe(%Horoscorpe{} = horoscorpe, attrs \\ %{}) do
    Horoscorpe.changeset(horoscorpe, attrs)
  end
end
