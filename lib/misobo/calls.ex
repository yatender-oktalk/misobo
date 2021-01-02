defmodule Misobo.Calls do
  @moduledoc """
  The Calls context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Calls.Call

  @doc """
  Returns the list of calls.

  ## Examples

      iex> list_calls()
      [%Call{}, ...]

  """
  def list_calls do
    Repo.all(Call)
  end

  @doc """
  Gets a single call.

  Raises `Ecto.NoResultsError` if the Call does not exist.

  ## Examples

      iex> get_call!(123)
      %Call{}

      iex> get_call!(456)
      ** (Ecto.NoResultsError)

  """
  def get_call!(id), do: Repo.get!(Call, id)

  @doc """
  Creates a call.

  ## Examples

      iex> create_call(%{field: value})
      {:ok, %Call{}}

      iex> create_call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_call(attrs \\ %{}) do
    attrs = modify_keys(attrs)

    %Call{}
    |> Call.changeset(attrs)
    |> Repo.insert()
  end

  def modify_keys(resp) do
    Enum.reduce(resp, %{}, fn {k, v}, acc ->
      key = k |> Phoenix.Naming.underscore()
      Map.put(acc, key, v)
    end)
  end

  @doc """
  Updates a call.

  ## Examples

      iex> update_call(call, %{field: new_value})
      {:ok, %Call{}}

      iex> update_call(call, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_call(%Call{} = call, attrs) do
    call
    |> Call.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a call.

  ## Examples

      iex> delete_call(call)
      {:ok, %Call{}}

      iex> delete_call(call)
      {:error, %Ecto.Changeset{}}

  """
  def delete_call(%Call{} = call) do
    Repo.delete(call)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking call changes.

  ## Examples

      iex> change_call(call)
      %Ecto.Changeset{data: %Call{}}

  """
  def change_call(%Call{} = call, attrs \\ %{}) do
    Call.changeset(call, attrs)
  end
end
