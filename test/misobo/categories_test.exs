defmodule Misobo.CategoriesTest do
  use Misobo.DataCase

  alias Misobo.Categories

  describe "registration_categories" do
    alias Misobo.Categories.RegistrationCategory

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def registration_category_fixture(attrs \\ %{}) do
      {:ok, registration_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Categories.create_registration_category()

      registration_category
    end

    test "list_registration_categories/0 returns all registration_categories" do
      registration_category = registration_category_fixture()
      assert Categories.list_registration_categories() == [registration_category]
    end

    test "get_registration_category!/1 returns the registration_category with given id" do
      registration_category = registration_category_fixture()
      assert Categories.get_registration_category!(registration_category.id) == registration_category
    end

    test "create_registration_category/1 with valid data creates a registration_category" do
      assert {:ok, %RegistrationCategory{} = registration_category} = Categories.create_registration_category(@valid_attrs)
    end

    test "create_registration_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_registration_category(@invalid_attrs)
    end

    test "update_registration_category/2 with valid data updates the registration_category" do
      registration_category = registration_category_fixture()
      assert {:ok, %RegistrationCategory{} = registration_category} = Categories.update_registration_category(registration_category, @update_attrs)
    end

    test "update_registration_category/2 with invalid data returns error changeset" do
      registration_category = registration_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Categories.update_registration_category(registration_category, @invalid_attrs)
      assert registration_category == Categories.get_registration_category!(registration_category.id)
    end

    test "delete_registration_category/1 deletes the registration_category" do
      registration_category = registration_category_fixture()
      assert {:ok, %RegistrationCategory{}} = Categories.delete_registration_category(registration_category)
      assert_raise Ecto.NoResultsError, fn -> Categories.get_registration_category!(registration_category.id) end
    end

    test "change_registration_category/1 returns a registration_category changeset" do
      registration_category = registration_category_fixture()
      assert %Ecto.Changeset{} = Categories.change_registration_category(registration_category)
    end
  end

  describe "registration_sub_categories" do
    alias Misobo.Categories.RegistrationSubCategory

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def registration_sub_category_fixture(attrs \\ %{}) do
      {:ok, registration_sub_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Categories.create_registration_sub_category()

      registration_sub_category
    end

    test "list_registration_sub_categories/0 returns all registration_sub_categories" do
      registration_sub_category = registration_sub_category_fixture()
      assert Categories.list_registration_sub_categories() == [registration_sub_category]
    end

    test "get_registration_sub_category!/1 returns the registration_sub_category with given id" do
      registration_sub_category = registration_sub_category_fixture()
      assert Categories.get_registration_sub_category!(registration_sub_category.id) == registration_sub_category
    end

    test "create_registration_sub_category/1 with valid data creates a registration_sub_category" do
      assert {:ok, %RegistrationSubCategory{} = registration_sub_category} = Categories.create_registration_sub_category(@valid_attrs)
    end

    test "create_registration_sub_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_registration_sub_category(@invalid_attrs)
    end

    test "update_registration_sub_category/2 with valid data updates the registration_sub_category" do
      registration_sub_category = registration_sub_category_fixture()
      assert {:ok, %RegistrationSubCategory{} = registration_sub_category} = Categories.update_registration_sub_category(registration_sub_category, @update_attrs)
    end

    test "update_registration_sub_category/2 with invalid data returns error changeset" do
      registration_sub_category = registration_sub_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Categories.update_registration_sub_category(registration_sub_category, @invalid_attrs)
      assert registration_sub_category == Categories.get_registration_sub_category!(registration_sub_category.id)
    end

    test "delete_registration_sub_category/1 deletes the registration_sub_category" do
      registration_sub_category = registration_sub_category_fixture()
      assert {:ok, %RegistrationSubCategory{}} = Categories.delete_registration_sub_category(registration_sub_category)
      assert_raise Ecto.NoResultsError, fn -> Categories.get_registration_sub_category!(registration_sub_category.id) end
    end

    test "change_registration_sub_category/1 returns a registration_sub_category changeset" do
      registration_sub_category = registration_sub_category_fixture()
      assert %Ecto.Changeset{} = Categories.change_registration_sub_category(registration_sub_category)
    end
  end
end
