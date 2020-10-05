defmodule Misobo.CategoryTest do
  @moduledoc """
  This module has tests related to category endpoint
  """
  use Misobo.DataCase

  alias Misobo.Categories

  describe "categories" do
    alias Misobo.Category

    @valid_attrs %{
      name: "some-category-name",
      desc: "some-description"
    }

    @update_attrs %{
      name: "some-updated-name",
      desc: "some-updated-description"
    }

    @invalid_attrs %{
      name: nil,
      desc: nil
    }

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Categories.create_category()

      category
    end

    test "list_categories/0 returns all category" do
      category = category_fixture()
      assert Categories.list_categories() == [category]
    end

    test "get category by id" do
      category = category_fixture()
      assert Categories.get_category(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Categories.create_category(@valid_attrs)
      assert category.name == "some-category-name"
      assert category.desc == "some-description"
    end

    test "update_category/1 with valid data update a category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Categories.update_category(category, @update_attrs)
      assert category.name == "some-updated-name"
      assert category.desc == "some-updated-description"
    end

    test "update_user/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Categories.update_category(category, @invalid_attrs)
      assert category == Categories.get_category(category.id)
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_category(@invalid_attrs)
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Categories.change_category(category)
    end
  end
end
