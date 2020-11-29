defmodule Misobo.Blogs.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :category,
               :content,
               :is_enabled,
               :title
             ]
           ]}
  schema "blogs" do
    field :category, :string
    field :content, :string
    field :is_enabled, :boolean, default: false
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:title, :content, :is_enabled, :category])
    |> validate_required([:title, :content, :is_enabled])
  end
end
