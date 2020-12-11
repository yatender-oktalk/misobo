defmodule Misobo.Rewards do
  @moduledoc """
  The Rewards context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Rewards.Reward

  @doc """
  Returns the list of rewards.

  ## Examples

      iex> list_rewards()
      [%Reward{}, ...]

  """
  def list_rewards do
    query =
      from u in Reward,
        where: u.is_active == true

    Repo.all(query)
  end

  @doc """
  Gets a single reward.

  Raises `Ecto.NoResultsError` if the Reward does not exist.

  ## Examples

      iex> get_reward!(123)
      %Reward{}

      iex> get_reward!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward!(id), do: Repo.get!(Reward, id)

  def get_reward(id), do: Repo.get(Reward, id)

  @doc """
  Creates a reward.

  ## Examples

      iex> create_reward(%{field: value})
      {:ok, %Reward{}}

      iex> create_reward(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward(attrs \\ %{}) do
    %Reward{}
    |> Reward.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reward.

  ## Examples

      iex> update_reward(reward, %{field: new_value})
      {:ok, %Reward{}}

      iex> update_reward(reward, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward(%Reward{} = reward, attrs) do
    reward
    |> Reward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward.

  ## Examples

      iex> delete_reward(reward)
      {:ok, %Reward{}}

      iex> delete_reward(reward)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward(%Reward{} = reward) do
    Repo.delete(reward)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward changes.

  ## Examples

      iex> change_reward(reward)
      %Ecto.Changeset{data: %Reward{}}

  """
  def change_reward(%Reward{} = reward, attrs \\ %{}) do
    Reward.changeset(reward, attrs)
  end

  alias Misobo.Rewards.RewardCode

  @doc """
  Returns the list of reward_codes.

  ## Examples

      iex> list_reward_codes()
      [%RewardCode{}, ...]

  """
  def list_reward_codes do
    Repo.all(RewardCode)
  end

  @doc """
  Gets a single reward_code.

  Raises `Ecto.NoResultsError` if the Reward code does not exist.

  ## Examples

      iex> get_reward_code!(123)
      %RewardCode{}

      iex> get_reward_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward_code!(id), do: Repo.get!(RewardCode, id)

  @doc """
  Creates a reward_code.

  ## Examples

      iex> create_reward_code(%{field: value})
      {:ok, %RewardCode{}}

      iex> create_reward_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward_code(attrs \\ %{}) do
    %RewardCode{}
    |> RewardCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reward_code.

  ## Examples

      iex> update_reward_code(reward_code, %{field: new_value})
      {:ok, %RewardCode{}}

      iex> update_reward_code(reward_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward_code(%RewardCode{} = reward_code, attrs) do
    reward_code
    |> RewardCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward_code.

  ## Examples

      iex> delete_reward_code(reward_code)
      {:ok, %RewardCode{}}

      iex> delete_reward_code(reward_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward_code(%RewardCode{} = reward_code) do
    Repo.delete(reward_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward_code changes.

  ## Examples

      iex> change_reward_code(reward_code)
      %Ecto.Changeset{data: %RewardCode{}}

  """
  def change_reward_code(%RewardCode{} = reward_code, attrs \\ %{}) do
    RewardCode.changeset(reward_code, attrs)
  end

  alias Misobo.Rewards.UserRewards

  @doc """
  Returns the list of user_rewards.

  ## Examples

      iex> list_user_rewards()
      [%UserRewards{}, ...]

  """
  def list_user_rewards do
    Repo.all(UserRewards)
  end

  @doc """
  Gets a single user_rewards.

  Raises `Ecto.NoResultsError` if the User rewards does not exist.

  ## Examples

      iex> get_user_rewards!(123)
      %UserRewards{}

      iex> get_user_rewards!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_rewards!(id), do: Repo.get!(UserRewards, id)

  @doc """
  Creates a user_rewards.

  ## Examples

      iex> create_user_rewards(%{field: value})
      {:ok, %UserRewards{}}

      iex> create_user_rewards(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_rewards(attrs \\ %{}) do
    %UserRewards{}
    |> UserRewards.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_rewards.

  ## Examples

      iex> update_user_rewards(user_rewards, %{field: new_value})
      {:ok, %UserRewards{}}

      iex> update_user_rewards(user_rewards, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_rewards(%UserRewards{} = user_rewards, attrs) do
    user_rewards
    |> UserRewards.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_rewards.

  ## Examples

      iex> delete_user_rewards(user_rewards)
      {:ok, %UserRewards{}}

      iex> delete_user_rewards(user_rewards)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_rewards(%UserRewards{} = user_rewards) do
    Repo.delete(user_rewards)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_rewards changes.

  ## Examples

      iex> change_user_rewards(user_rewards)
      %Ecto.Changeset{data: %UserRewards{}}

  """
  def change_user_rewards(%UserRewards{} = user_rewards, attrs \\ %{}) do
    UserRewards.changeset(user_rewards, attrs)
  end
end
