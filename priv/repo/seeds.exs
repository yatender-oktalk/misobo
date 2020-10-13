# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Misobo.Repo.insert!(%Misobo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# alias Misobo.Accounts.User
alias Misobo.Category
alias Misobo.SubCategory
alias Misobo.Categories
alias Misobo.Experts
alias Misobo.Experts.ExpertCategory
alias Misobo.Experts.Expert
alias Misobo.Repo

base_path = "./priv/repo/seeds/seed_fixtures/"

Repo.delete_all(SubCategory)
Repo.delete_all(Category)
# insert category
(base_path <> "category.json")
|> Path.expand()
|> File.read!()
|> Jason.decode!()
|> Enum.map(fn category ->
  Categories.create_category(category)
end)

category = Categories.get_category_by(%{name: "Reduce Stress"})

(base_path <> "sub_category.json")
|> Path.expand()
|> File.read!()
|> Jason.decode!()
|> Enum.map(fn sub_category ->
  sub_category = Map.put(sub_category, "category_id", category.id)

  Categories.create_sub_category(sub_category)
end)

Repo.delete_all(ExpertCategory)

(base_path <> "expert_category.json")
|> Path.expand()
|> File.read!()
|> Jason.decode!()
|> Enum.map(fn expert_category ->
  Experts.create_expert_category(expert_category)
end)

Repo.delete_all(Expert)

(base_path <> "expert.json")
|> Path.expand()
|> File.read!()
|> Jason.decode!()
|> Enum.map(fn expert ->
  {:ok, exp} = Experts.create_expert(expert)

  exp = Repo.preload(exp, :expert_categories)

  expert_categories =
    Enum.map(expert["categories"], fn exp_category ->
      Repo.get_by(ExpertCategory, %{name: exp_category})
    end)
    |> Enum.map(fn expert -> expert.id end)

  IO.inspect(expert_categories)
  Experts.upsert_expert_expert_categories(exp, expert_categories)
end)
