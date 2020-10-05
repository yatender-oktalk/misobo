defmodule MisoboWeb.CategoryControllerTest do
  @moduledoc """
  This module tests the category controller logic
  """
  use MisoboWeb.ConnCase, async: true

  describe "Fetch Categories" do
    test "Category fetch with subcateogries", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index, %{}))
      assert conn.status == 200
    end
  end
end
