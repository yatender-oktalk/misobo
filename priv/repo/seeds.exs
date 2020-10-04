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
IO.inspect(category)

(base_path <> "sub_category.json")
|> Path.expand()
|> File.read!()
|> Jason.decode!()
|> Enum.map(fn sub_category ->
  sub_category = Map.put(sub_category, "category_id", category.id)

  Categories.create_sub_category(sub_category)
end)
