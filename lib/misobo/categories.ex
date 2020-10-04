defmodule Misobo.Categories do
  @moduledoc """
  The Categories context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Category
  alias Misobo.SubCategory

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Retruns `nil` if the category does not exist.

  ## Examples

      iex> get_category(123)
      {:ok, %category{}}

      iex> get_category(456)
      {:ok, nil}

  """
  def get_category(id), do: Repo.get(Category, id)

  def get_category_by(params), do: Repo.get_by(Category, params)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a sub_category.

  ## Examples

      iex> create_sub_category(%{field: value})
      {:ok, %SubCategory{}}

      iex> create_sub_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_category(attrs \\ %{}) do
    %SubCategory{}
    |> SubCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_cateogry(cateogry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  def get_categories_with_sub_categories do
    preload_query = from sc in SubCategory, where: sc.is_enabled == true

    base_category_query()
    |> get_enabled_category()
    |> preload_sub_categories(preload_query)
    |> Repo.all()
  end

  defp base_category_query, do: from(u in Category)

  defp get_enabled_category(query), do: query |> where([u], u.is_enabled == true)

  defp preload_sub_categories(query, preload_query),
    do: query |> preload(sub_category: ^preload_query)
end
