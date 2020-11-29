defmodule Misobo.PacksTest do
  use Misobo.DataCase

  alias Misobo.Packs

  describe "packs" do
    alias Misobo.Packs.Pack

    @valid_attrs %{amount: "120.5", is_enabled: true, karma_coins: 42}
    @update_attrs %{amount: "456.7", is_enabled: false, karma_coins: 43}
    @invalid_attrs %{amount: nil, is_enabled: nil, karma_coins: nil}

    def pack_fixture(attrs \\ %{}) do
      {:ok, pack} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Packs.create_pack()

      pack
    end

    test "list_packs/0 returns all packs" do
      pack = pack_fixture()
      assert Packs.list_packs() == [pack]
    end

    test "get_pack!/1 returns the pack with given id" do
      pack = pack_fixture()
      assert Packs.get_pack!(pack.id) == pack
    end

    test "create_pack/1 with valid data creates a pack" do
      assert {:ok, %Pack{} = pack} = Packs.create_pack(@valid_attrs)
      assert pack.amount == Decimal.new("120.5")
      assert pack.is_enabled == true
      assert pack.karma_coins == 42
    end

    test "create_pack/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Packs.create_pack(@invalid_attrs)
    end

    test "update_pack/2 with valid data updates the pack" do
      pack = pack_fixture()
      assert {:ok, %Pack{} = pack} = Packs.update_pack(pack, @update_attrs)
      assert pack.amount == Decimal.new("456.7")
      assert pack.is_enabled == false
      assert pack.karma_coins == 43
    end

    test "update_pack/2 with invalid data returns error changeset" do
      pack = pack_fixture()
      assert {:error, %Ecto.Changeset{}} = Packs.update_pack(pack, @invalid_attrs)
      assert pack == Packs.get_pack!(pack.id)
    end

    test "delete_pack/1 deletes the pack" do
      pack = pack_fixture()
      assert {:ok, %Pack{}} = Packs.delete_pack(pack)
      assert_raise Ecto.NoResultsError, fn -> Packs.get_pack!(pack.id) end
    end

    test "change_pack/1 returns a pack changeset" do
      pack = pack_fixture()
      assert %Ecto.Changeset{} = Packs.change_pack(pack)
    end
  end
end
