defmodule Misobo.Packs do
  @moduledoc """
  The Packs context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Packs.Pack

  @doc """
  Returns the list of packs.

  ## Examples

      iex> list_packs()
      [%Pack{}, ...]

  """
  def list_packs do
    Repo.all(Pack)
  end

  def activated_packs do
    list_packs()
    |> Enum.reject(fn pack -> pack.is_enabled == false end)
  end

  @doc """
  Gets a single pack.

  Raises `Ecto.NoResultsError` if the Pack does not exist.

  ## Examples

      iex> get_pack!(123)
      %Pack{}

      iex> get_pack!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pack!(id), do: Repo.get!(Pack, id)

  def get_pack(id), do: Repo.get(Pack, id)

  @doc """
  Creates a pack.

  ## Examples

      iex> create_pack(%{field: value})
      {:ok, %Pack{}}

      iex> create_pack(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pack(attrs \\ %{}) do
    %Pack{}
    |> Pack.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pack.

  ## Examples

      iex> update_pack(pack, %{field: new_value})
      {:ok, %Pack{}}

      iex> update_pack(pack, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pack(%Pack{} = pack, attrs) do
    pack
    |> Pack.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pack.

  ## Examples

      iex> delete_pack(pack)
      {:ok, %Pack{}}

      iex> delete_pack(pack)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pack(%Pack{} = pack) do
    Repo.delete(pack)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pack changes.

  ## Examples

      iex> change_pack(pack)
      %Ecto.Changeset{data: %Pack{}}

  """
  def change_pack(%Pack{} = pack, attrs \\ %{}) do
    Pack.changeset(pack, attrs)
  end
end
