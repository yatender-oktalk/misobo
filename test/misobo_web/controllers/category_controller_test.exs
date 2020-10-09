defmodule MisoboWeb.CategoryControllerTest do
  @moduledoc """
  This module tests the category controller logic
  """
  use MisoboWeb.ConnCase, async: true
  alias Misobo.Accounts
  alias Misobo.Accounts.User

  describe "Fetch Categories" do
    setup %{conn: conn} do
      phone = "9090901234"
      # singup a new user then verify him and then set the token
      post(conn, Routes.account_path(conn, :create, %{phone: phone}))
      %User{otp: otp} = Accounts.get_user_by(%{phone: phone})

      login_conn =
        post(conn, Routes.account_path(conn, :login, %{"phone" => phone, "otp" => otp}))

      %{"token" => token} = Jason.decode!(login_conn.resp_body)
      {:ok, conn: put_req_header(conn, "token", token)}
    end

    test "Category fetch with subcateogries", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index, %{}))
      assert conn.status == 200
    end
  end
end
