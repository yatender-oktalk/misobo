defmodule Misobo.RewardsTest do
  use Misobo.DataCase

  alias Misobo.Rewards

  describe "rewards" do
    alias Misobo.Rewards.Reward

    @valid_attrs %{company: "some company", company_logo: "some company_logo", how_to_redeem: "some how_to_redeem", img: "some img", karma: 42, offer_details: "some offer_details", people_unlocked: 42, terms_and_conditions: "some terms_and_conditions", title: "some title"}
    @update_attrs %{company: "some updated company", company_logo: "some updated company_logo", how_to_redeem: "some updated how_to_redeem", img: "some updated img", karma: 43, offer_details: "some updated offer_details", people_unlocked: 43, terms_and_conditions: "some updated terms_and_conditions", title: "some updated title"}
    @invalid_attrs %{company: nil, company_logo: nil, how_to_redeem: nil, img: nil, karma: nil, offer_details: nil, people_unlocked: nil, terms_and_conditions: nil, title: nil}

    def reward_fixture(attrs \\ %{}) do
      {:ok, reward} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rewards.create_reward()

      reward
    end

    test "list_rewards/0 returns all rewards" do
      reward = reward_fixture()
      assert Rewards.list_rewards() == [reward]
    end

    test "get_reward!/1 returns the reward with given id" do
      reward = reward_fixture()
      assert Rewards.get_reward!(reward.id) == reward
    end

    test "create_reward/1 with valid data creates a reward" do
      assert {:ok, %Reward{} = reward} = Rewards.create_reward(@valid_attrs)
      assert reward.company == "some company"
      assert reward.company_logo == "some company_logo"
      assert reward.how_to_redeem == "some how_to_redeem"
      assert reward.img == "some img"
      assert reward.karma == 42
      assert reward.offer_details == "some offer_details"
      assert reward.people_unlocked == 42
      assert reward.terms_and_conditions == "some terms_and_conditions"
      assert reward.title == "some title"
    end

    test "create_reward/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rewards.create_reward(@invalid_attrs)
    end

    test "update_reward/2 with valid data updates the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{} = reward} = Rewards.update_reward(reward, @update_attrs)
      assert reward.company == "some updated company"
      assert reward.company_logo == "some updated company_logo"
      assert reward.how_to_redeem == "some updated how_to_redeem"
      assert reward.img == "some updated img"
      assert reward.karma == 43
      assert reward.offer_details == "some updated offer_details"
      assert reward.people_unlocked == 43
      assert reward.terms_and_conditions == "some updated terms_and_conditions"
      assert reward.title == "some updated title"
    end

    test "update_reward/2 with invalid data returns error changeset" do
      reward = reward_fixture()
      assert {:error, %Ecto.Changeset{}} = Rewards.update_reward(reward, @invalid_attrs)
      assert reward == Rewards.get_reward!(reward.id)
    end

    test "delete_reward/1 deletes the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{}} = Rewards.delete_reward(reward)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_reward!(reward.id) end
    end

    test "change_reward/1 returns a reward changeset" do
      reward = reward_fixture()
      assert %Ecto.Changeset{} = Rewards.change_reward(reward)
    end
  end

  describe "reward_codes" do
    alias Misobo.Rewards.RewardCode

    @valid_attrs %{code: "some code", is_active: true, redeemed_on: ~N[2010-04-17 14:00:00], valid_from: ~N[2010-04-17 14:00:00], valid_upto: ~N[2010-04-17 14:00:00]}
    @update_attrs %{code: "some updated code", is_active: false, redeemed_on: ~N[2011-05-18 15:01:01], valid_from: ~N[2011-05-18 15:01:01], valid_upto: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{code: nil, is_active: nil, redeemed_on: nil, valid_from: nil, valid_upto: nil}

    def reward_code_fixture(attrs \\ %{}) do
      {:ok, reward_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rewards.create_reward_code()

      reward_code
    end

    test "list_reward_codes/0 returns all reward_codes" do
      reward_code = reward_code_fixture()
      assert Rewards.list_reward_codes() == [reward_code]
    end

    test "get_reward_code!/1 returns the reward_code with given id" do
      reward_code = reward_code_fixture()
      assert Rewards.get_reward_code!(reward_code.id) == reward_code
    end

    test "create_reward_code/1 with valid data creates a reward_code" do
      assert {:ok, %RewardCode{} = reward_code} = Rewards.create_reward_code(@valid_attrs)
      assert reward_code.code == "some code"
      assert reward_code.is_active == true
      assert reward_code.redeemed_on == ~N[2010-04-17 14:00:00]
      assert reward_code.valid_from == ~N[2010-04-17 14:00:00]
      assert reward_code.valid_upto == ~N[2010-04-17 14:00:00]
    end

    test "create_reward_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rewards.create_reward_code(@invalid_attrs)
    end

    test "update_reward_code/2 with valid data updates the reward_code" do
      reward_code = reward_code_fixture()
      assert {:ok, %RewardCode{} = reward_code} = Rewards.update_reward_code(reward_code, @update_attrs)
      assert reward_code.code == "some updated code"
      assert reward_code.is_active == false
      assert reward_code.redeemed_on == ~N[2011-05-18 15:01:01]
      assert reward_code.valid_from == ~N[2011-05-18 15:01:01]
      assert reward_code.valid_upto == ~N[2011-05-18 15:01:01]
    end

    test "update_reward_code/2 with invalid data returns error changeset" do
      reward_code = reward_code_fixture()
      assert {:error, %Ecto.Changeset{}} = Rewards.update_reward_code(reward_code, @invalid_attrs)
      assert reward_code == Rewards.get_reward_code!(reward_code.id)
    end

    test "delete_reward_code/1 deletes the reward_code" do
      reward_code = reward_code_fixture()
      assert {:ok, %RewardCode{}} = Rewards.delete_reward_code(reward_code)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_reward_code!(reward_code.id) end
    end

    test "change_reward_code/1 returns a reward_code changeset" do
      reward_code = reward_code_fixture()
      assert %Ecto.Changeset{} = Rewards.change_reward_code(reward_code)
    end
  end

  describe "user_rewards" do
    alias Misobo.Rewards.UserRewards

    @valid_attrs %{expire_at: ~N[2010-04-17 14:00:00], redeemed_at: ~N[2010-04-17 14:00:00], reward_code: "some reward_code"}
    @update_attrs %{expire_at: ~N[2011-05-18 15:01:01], redeemed_at: ~N[2011-05-18 15:01:01], reward_code: "some updated reward_code"}
    @invalid_attrs %{expire_at: nil, redeemed_at: nil, reward_code: nil}

    def user_rewards_fixture(attrs \\ %{}) do
      {:ok, user_rewards} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rewards.create_user_rewards()

      user_rewards
    end

    test "list_user_rewards/0 returns all user_rewards" do
      user_rewards = user_rewards_fixture()
      assert Rewards.list_user_rewards() == [user_rewards]
    end

    test "get_user_rewards!/1 returns the user_rewards with given id" do
      user_rewards = user_rewards_fixture()
      assert Rewards.get_user_rewards!(user_rewards.id) == user_rewards
    end

    test "create_user_rewards/1 with valid data creates a user_rewards" do
      assert {:ok, %UserRewards{} = user_rewards} = Rewards.create_user_rewards(@valid_attrs)
      assert user_rewards.expire_at == ~N[2010-04-17 14:00:00]
      assert user_rewards.redeemed_at == ~N[2010-04-17 14:00:00]
      assert user_rewards.reward_code == "some reward_code"
    end

    test "create_user_rewards/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rewards.create_user_rewards(@invalid_attrs)
    end

    test "update_user_rewards/2 with valid data updates the user_rewards" do
      user_rewards = user_rewards_fixture()
      assert {:ok, %UserRewards{} = user_rewards} = Rewards.update_user_rewards(user_rewards, @update_attrs)
      assert user_rewards.expire_at == ~N[2011-05-18 15:01:01]
      assert user_rewards.redeemed_at == ~N[2011-05-18 15:01:01]
      assert user_rewards.reward_code == "some updated reward_code"
    end

    test "update_user_rewards/2 with invalid data returns error changeset" do
      user_rewards = user_rewards_fixture()
      assert {:error, %Ecto.Changeset{}} = Rewards.update_user_rewards(user_rewards, @invalid_attrs)
      assert user_rewards == Rewards.get_user_rewards!(user_rewards.id)
    end

    test "delete_user_rewards/1 deletes the user_rewards" do
      user_rewards = user_rewards_fixture()
      assert {:ok, %UserRewards{}} = Rewards.delete_user_rewards(user_rewards)
      assert_raise Ecto.NoResultsError, fn -> Rewards.get_user_rewards!(user_rewards.id) end
    end

    test "change_user_rewards/1 returns a user_rewards changeset" do
      user_rewards = user_rewards_fixture()
      assert %Ecto.Changeset{} = Rewards.change_user_rewards(user_rewards)
    end
  end
end
