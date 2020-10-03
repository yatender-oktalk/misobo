defmodule Misobo.AstrologyTest do
  use Misobo.DataCase

  alias Misobo.Astrology

  describe "horoscopes" do
    alias Misobo.Astrology.Horoscorpe

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def horoscorpe_fixture(attrs \\ %{}) do
      {:ok, horoscorpe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Astrology.create_horoscorpe()

      horoscorpe
    end

    test "list_horoscopes/0 returns all horoscopes" do
      horoscorpe = horoscorpe_fixture()
      assert Astrology.list_horoscopes() == [horoscorpe]
    end

    test "get_horoscorpe!/1 returns the horoscorpe with given id" do
      horoscorpe = horoscorpe_fixture()
      assert Astrology.get_horoscorpe!(horoscorpe.id) == horoscorpe
    end

    test "create_horoscorpe/1 with valid data creates a horoscorpe" do
      assert {:ok, %Horoscorpe{} = horoscorpe} = Astrology.create_horoscorpe(@valid_attrs)
      assert horoscorpe.name == "some name"
    end

    test "create_horoscorpe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Astrology.create_horoscorpe(@invalid_attrs)
    end

    test "update_horoscorpe/2 with valid data updates the horoscorpe" do
      horoscorpe = horoscorpe_fixture()

      assert {:ok, %Horoscorpe{} = horoscorpe} =
               Astrology.update_horoscorpe(horoscorpe, @update_attrs)

      assert horoscorpe.name == "some updated name"
    end

    test "update_horoscorpe/2 with invalid data returns error changeset" do
      horoscorpe = horoscorpe_fixture()
      assert {:error, %Ecto.Changeset{}} = Astrology.update_horoscorpe(horoscorpe, @invalid_attrs)
      assert horoscorpe == Astrology.get_horoscorpe!(horoscorpe.id)
    end

    test "delete_horoscorpe/1 deletes the horoscorpe" do
      horoscorpe = horoscorpe_fixture()
      assert {:ok, %Horoscorpe{}} = Astrology.delete_horoscorpe(horoscorpe)
      assert_raise Ecto.NoResultsError, fn -> Astrology.get_horoscorpe!(horoscorpe.id) end
    end

    test "change_horoscorpe/1 returns a horoscorpe changeset" do
      horoscorpe = horoscorpe_fixture()
      assert %Ecto.Changeset{} = Astrology.change_horoscorpe(horoscorpe)
    end
  end
end
