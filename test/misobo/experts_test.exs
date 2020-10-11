defmodule Misobo.ExpertsTest do
  use Misobo.DataCase

  alias Misobo.Experts

  describe "expert_categories" do
    alias Misobo.Experts.ExpertCategory

    @valid_attrs %{enabled_at: ~N[2010-04-17 14:00:00], is_enabled: true, name: "some name"}
    @update_attrs %{enabled_at: ~N[2011-05-18 15:01:01], is_enabled: false, name: "some updated name"}
    @invalid_attrs %{enabled_at: nil, is_enabled: nil, name: nil}

    def expert_category_fixture(attrs \\ %{}) do
      {:ok, expert_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Experts.create_expert_category()

      expert_category
    end

    test "list_expert_categories/0 returns all expert_categories" do
      expert_category = expert_category_fixture()
      assert Experts.list_expert_categories() == [expert_category]
    end

    test "get_expert_category!/1 returns the expert_category with given id" do
      expert_category = expert_category_fixture()
      assert Experts.get_expert_category!(expert_category.id) == expert_category
    end

    test "create_expert_category/1 with valid data creates a expert_category" do
      assert {:ok, %ExpertCategory{} = expert_category} = Experts.create_expert_category(@valid_attrs)
      assert expert_category.enabled_at == ~N[2010-04-17 14:00:00]
      assert expert_category.is_enabled == true
      assert expert_category.name == "some name"
    end

    test "create_expert_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experts.create_expert_category(@invalid_attrs)
    end

    test "update_expert_category/2 with valid data updates the expert_category" do
      expert_category = expert_category_fixture()
      assert {:ok, %ExpertCategory{} = expert_category} = Experts.update_expert_category(expert_category, @update_attrs)
      assert expert_category.enabled_at == ~N[2011-05-18 15:01:01]
      assert expert_category.is_enabled == false
      assert expert_category.name == "some updated name"
    end

    test "update_expert_category/2 with invalid data returns error changeset" do
      expert_category = expert_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Experts.update_expert_category(expert_category, @invalid_attrs)
      assert expert_category == Experts.get_expert_category!(expert_category.id)
    end

    test "delete_expert_category/1 deletes the expert_category" do
      expert_category = expert_category_fixture()
      assert {:ok, %ExpertCategory{}} = Experts.delete_expert_category(expert_category)
      assert_raise Ecto.NoResultsError, fn -> Experts.get_expert_category!(expert_category.id) end
    end

    test "change_expert_category/1 returns a expert_category changeset" do
      expert_category = expert_category_fixture()
      assert %Ecto.Changeset{} = Experts.change_expert_category(expert_category)
    end
  end

  describe "experts" do
    alias Misobo.Experts.Expert

    @valid_attrs %{about: "some about", category_order: 42, consult_karma: 42, experience: 42, img: "some img", is_enabled: true, language: "some language", name: "some name", order: 42, rating: "120.5", total_consultations: 42}
    @update_attrs %{about: "some updated about", category_order: 43, consult_karma: 43, experience: 43, img: "some updated img", is_enabled: false, language: "some updated language", name: "some updated name", order: 43, rating: "456.7", total_consultations: 43}
    @invalid_attrs %{about: nil, category_order: nil, consult_karma: nil, experience: nil, img: nil, is_enabled: nil, language: nil, name: nil, order: nil, rating: nil, total_consultations: nil}

    def expert_fixture(attrs \\ %{}) do
      {:ok, expert} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Experts.create_expert()

      expert
    end

    test "list_experts/0 returns all experts" do
      expert = expert_fixture()
      assert Experts.list_experts() == [expert]
    end

    test "get_expert!/1 returns the expert with given id" do
      expert = expert_fixture()
      assert Experts.get_expert!(expert.id) == expert
    end

    test "create_expert/1 with valid data creates a expert" do
      assert {:ok, %Expert{} = expert} = Experts.create_expert(@valid_attrs)
      assert expert.about == "some about"
      assert expert.category_order == 42
      assert expert.consult_karma == 42
      assert expert.experience == 42
      assert expert.img == "some img"
      assert expert.is_enabled == true
      assert expert.language == "some language"
      assert expert.name == "some name"
      assert expert.order == 42
      assert expert.rating == Decimal.new("120.5")
      assert expert.total_consultations == 42
    end

    test "create_expert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experts.create_expert(@invalid_attrs)
    end

    test "update_expert/2 with valid data updates the expert" do
      expert = expert_fixture()
      assert {:ok, %Expert{} = expert} = Experts.update_expert(expert, @update_attrs)
      assert expert.about == "some updated about"
      assert expert.category_order == 43
      assert expert.consult_karma == 43
      assert expert.experience == 43
      assert expert.img == "some updated img"
      assert expert.is_enabled == false
      assert expert.language == "some updated language"
      assert expert.name == "some updated name"
      assert expert.order == 43
      assert expert.rating == Decimal.new("456.7")
      assert expert.total_consultations == 43
    end

    test "update_expert/2 with invalid data returns error changeset" do
      expert = expert_fixture()
      assert {:error, %Ecto.Changeset{}} = Experts.update_expert(expert, @invalid_attrs)
      assert expert == Experts.get_expert!(expert.id)
    end

    test "delete_expert/1 deletes the expert" do
      expert = expert_fixture()
      assert {:ok, %Expert{}} = Experts.delete_expert(expert)
      assert_raise Ecto.NoResultsError, fn -> Experts.get_expert!(expert.id) end
    end

    test "change_expert/1 returns a expert changeset" do
      expert = expert_fixture()
      assert %Ecto.Changeset{} = Experts.change_expert(expert)
    end
  end

  describe "expert_category_mappings" do
    alias Misobo.Experts.ExpertCategoryMapping

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def expert_category_mapping_fixture(attrs \\ %{}) do
      {:ok, expert_category_mapping} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Experts.create_expert_category_mapping()

      expert_category_mapping
    end

    test "list_expert_category_mappings/0 returns all expert_category_mappings" do
      expert_category_mapping = expert_category_mapping_fixture()
      assert Experts.list_expert_category_mappings() == [expert_category_mapping]
    end

    test "get_expert_category_mapping!/1 returns the expert_category_mapping with given id" do
      expert_category_mapping = expert_category_mapping_fixture()
      assert Experts.get_expert_category_mapping!(expert_category_mapping.id) == expert_category_mapping
    end

    test "create_expert_category_mapping/1 with valid data creates a expert_category_mapping" do
      assert {:ok, %ExpertCategoryMapping{} = expert_category_mapping} = Experts.create_expert_category_mapping(@valid_attrs)
    end

    test "create_expert_category_mapping/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experts.create_expert_category_mapping(@invalid_attrs)
    end

    test "update_expert_category_mapping/2 with valid data updates the expert_category_mapping" do
      expert_category_mapping = expert_category_mapping_fixture()
      assert {:ok, %ExpertCategoryMapping{} = expert_category_mapping} = Experts.update_expert_category_mapping(expert_category_mapping, @update_attrs)
    end

    test "update_expert_category_mapping/2 with invalid data returns error changeset" do
      expert_category_mapping = expert_category_mapping_fixture()
      assert {:error, %Ecto.Changeset{}} = Experts.update_expert_category_mapping(expert_category_mapping, @invalid_attrs)
      assert expert_category_mapping == Experts.get_expert_category_mapping!(expert_category_mapping.id)
    end

    test "delete_expert_category_mapping/1 deletes the expert_category_mapping" do
      expert_category_mapping = expert_category_mapping_fixture()
      assert {:ok, %ExpertCategoryMapping{}} = Experts.delete_expert_category_mapping(expert_category_mapping)
      assert_raise Ecto.NoResultsError, fn -> Experts.get_expert_category_mapping!(expert_category_mapping.id) end
    end

    test "change_expert_category_mapping/1 returns a expert_category_mapping changeset" do
      expert_category_mapping = expert_category_mapping_fixture()
      assert %Ecto.Changeset{} = Experts.change_expert_category_mapping(expert_category_mapping)
    end
  end
end
