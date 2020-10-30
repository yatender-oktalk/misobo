defmodule Misobo.Experts do
  @moduledoc """
  The Experts context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Experts.ExpertCategory

  @doc """
  Returns the list of expert_categories.

  ## Examples

      iex> list_expert_categories()
      [%ExpertCategory{}, ...]

  """
  def list_expert_categories do
    Repo.all(ExpertCategory)
  end

  @doc """
  Gets a single expert_category.

  Raises `Ecto.NoResultsError` if the Expert category does not exist.

  ## Examples

      iex> get_expert_category!(123)
      %ExpertCategory{}

      iex> get_expert_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_category!(id), do: Repo.get!(ExpertCategory, id)

  @doc """
  Creates a expert_category.

  ## Examples

      iex> create_expert_category(%{field: value})
      {:ok, %ExpertCategory{}}

      iex> create_expert_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_category(attrs \\ %{}) do
    %ExpertCategory{}
    |> ExpertCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_category.

  ## Examples

      iex> update_expert_category(expert_category, %{field: new_value})
      {:ok, %ExpertCategory{}}

      iex> update_expert_category(expert_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_category(%ExpertCategory{} = expert_category, attrs) do
    expert_category
    |> ExpertCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_category.

  ## Examples

      iex> delete_expert_category(expert_category)
      {:ok, %ExpertCategory{}}

      iex> delete_expert_category(expert_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_category(%ExpertCategory{} = expert_category) do
    Repo.delete(expert_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_category changes.

  ## Examples

      iex> change_expert_category(expert_category)
      %Ecto.Changeset{data: %ExpertCategory{}}

  """
  def change_expert_category(%ExpertCategory{} = expert_category, attrs \\ %{}) do
    ExpertCategory.changeset(expert_category, attrs)
  end

  alias Misobo.Experts.Expert

  @doc """
  Returns the list of experts.

  ## Examples

      iex> list_experts()
      [%Expert{}, ...]

  """
  def list_experts do
    Repo.all(Expert)
  end

  @doc """
  Gets a single expert.

  Raises `Ecto.NoResultsError` if the Expert does not exist.

  ## Examples

      iex> get_expert!(123)
      %Expert{}

      iex> get_expert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert!(id), do: Repo.get!(Expert, id)

  @doc """
  Gets a single expert.

  Raises `Ecto.NoResultsError` if the Expert does not exist.

  ## Examples

      iex> get_expert(123)
      {:ok, %Expert{}}

      iex> get_expert(456)
      nil

  """
  def get_expert(id), do: Repo.get(Expert, id)

  @doc """
  Creates a expert.

  ## Examples

      iex> create_expert(%{field: value})
      {:ok, %Expert{}}

      iex> create_expert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert(attrs \\ %{}) do
    %Expert{}
    |> Expert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert.

  ## Examples

      iex> update_expert(expert, %{field: new_value})
      {:ok, %Expert{}}

      iex> update_expert(expert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert(%Expert{} = expert, attrs) do
    expert
    |> Expert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert.

  ## Examples

      iex> delete_expert(expert)
      {:ok, %Expert{}}

      iex> delete_expert(expert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert(%Expert{} = expert) do
    Repo.delete(expert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert changes.

  ## Examples

      iex> change_expert(expert)
      %Ecto.Changeset{data: %Expert{}}

  """
  def change_expert(%Expert{} = expert, attrs \\ %{}) do
    Expert.changeset(expert, attrs)
  end

  def fetch_experts(page) do
    expert_base() |> fetch_experts_remaining(page)
  end

  def fetch_experts_remaining(query, page) do
    query
    |> order_by(asc: :order)
    |> preload(:expert_categories)
    |> Repo.paginate(page: page)
  end

  def expert_base, do: from(u in Expert)

  alias Misobo.Experts.ExpertCategoryMapping

  @doc """
  Returns the list of expert_category_mappings.

  ## Examples

      iex> list_expert_category_mappings()
      [%ExpertCategoryMapping{}, ...]

  """
  def list_expert_category_mappings do
    Repo.all(ExpertCategoryMapping)
  end

  @doc """
  Gets a single expert_category_mapping.

  Raises `Ecto.NoResultsError` if the Expert category mapping does not exist.

  ## Examples

      iex> get_expert_category_mapping!(123)
      %ExpertCategoryMapping{}

      iex> get_expert_category_mapping!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_category_mapping!(id), do: Repo.get!(ExpertCategoryMapping, id)

  @doc """
  Creates a expert_category_mapping.

  ## Examples

      iex> create_expert_category_mapping(%{field: value})
      {:ok, %ExpertCategoryMapping{}}

      iex> create_expert_category_mapping(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_category_mapping(attrs \\ %{}) do
    %ExpertCategoryMapping{}
    |> ExpertCategoryMapping.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_category_mapping.

  ## Examples

      iex> update_expert_category_mapping(expert_category_mapping, %{field: new_value})
      {:ok, %ExpertCategoryMapping{}}

      iex> update_expert_category_mapping(expert_category_mapping, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_category_mapping(%ExpertCategoryMapping{} = expert_category_mapping, attrs) do
    expert_category_mapping
    |> ExpertCategoryMapping.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_category_mapping.

  ## Examples

      iex> delete_expert_category_mapping(expert_category_mapping)
      {:ok, %ExpertCategoryMapping{}}

      iex> delete_expert_category_mapping(expert_category_mapping)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_category_mapping(%ExpertCategoryMapping{} = expert_category_mapping) do
    Repo.delete(expert_category_mapping)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_category_mapping changes.

  ## Examples

      iex> change_expert_category_mapping(expert_category_mapping)
      %Ecto.Changeset{data: %ExpertCategoryMapping{}}

  """
  def change_expert_category_mapping(
        %ExpertCategoryMapping{} = expert_category_mapping,
        attrs \\ %{}
      ) do
    ExpertCategoryMapping.changeset(expert_category_mapping, attrs)
  end

  def upsert_expert_expert_categories(expert, expert_categories)
      when is_list(expert_categories) do
    expert_categories =
      ExpertCategory
      |> where([expert_category], expert_category.id in ^expert_categories)
      |> Repo.all()

    resp =
      expert
      |> Expert.changeset_update_expert_categories(expert_categories)
      |> Repo.update()

    case resp do
      {:ok, _struct} ->
        {:ok, get_expert(expert.id)}

      error ->
        {:error, error}
    end
  end

  def get_experts_for_category(id, page) do
    q =
      from u in ExpertCategoryMapping,
        join: c in Expert,
        on: c.id == u.expert_id,
        where: u.expert_category_id == ^id,
        where: c.is_enabled == true,
        select: c

    Repo.paginate(q, page: page)
  end
end
