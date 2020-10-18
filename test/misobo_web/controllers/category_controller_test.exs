defmodule MisoboWeb.CategoryControllerTest do
  @moduledoc """
  This module tests the category controller logic
  """
  use MisoboWeb.ConnCase, async: false

  describe "Fetch Categories" do
    setup %{conn: conn} do
      device_id = "abc1234"
      # create a new registration
      response = post(conn, Routes.registration_path(conn, :create, %{device_id: device_id}))
      %{"data" => %{"token" => token}} = Jason.decode!(response.resp_body)
      {:ok, conn: put_req_header(conn, "token", token)}
    end

    test "Category fetch with subcateogries", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index, %{}))
      assert conn.status == 200
    end
  end
end
