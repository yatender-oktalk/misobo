defmodule Misobo.BlogsTest do
  use Misobo.DataCase

  alias Misobo.Blogs

  describe "blogs" do
    alias Misobo.Blogs.Blog

    @valid_attrs %{category: "some category", content: "some content", is_enabled: true, title: "some title"}
    @update_attrs %{category: "some updated category", content: "some updated content", is_enabled: false, title: "some updated title"}
    @invalid_attrs %{category: nil, content: nil, is_enabled: nil, title: nil}

    def blog_fixture(attrs \\ %{}) do
      {:ok, blog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_blog()

      blog
    end

    test "list_blogs/0 returns all blogs" do
      blog = blog_fixture()
      assert Blogs.list_blogs() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert Blogs.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      assert {:ok, %Blog{} = blog} = Blogs.create_blog(@valid_attrs)
      assert blog.category == "some category"
      assert blog.content == "some content"
      assert blog.is_enabled == true
      assert blog.title == "some title"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{} = blog} = Blogs.update_blog(blog, @update_attrs)
      assert blog.category == "some updated category"
      assert blog.content == "some updated content"
      assert blog.is_enabled == false
      assert blog.title == "some updated title"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_blog(blog, @invalid_attrs)
      assert blog == Blogs.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = Blogs.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = Blogs.change_blog(blog)
    end
  end
end
