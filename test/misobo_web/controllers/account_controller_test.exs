defmodule MisoboWeb.AccountControllerTest do
  @moduledoc """
  This module tests the account controller logic
  """
  use MisoboWeb.ConnCase, async: true

  alias Misobo.Accounts
  alias Misobo.Accounts.User

  describe "user account onboarding" do
    test "signup test", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create, %{phone: "9090909090"}))
      assert conn.status == 201
      assert %{"data" => "user created successfully"} == Jason.decode!(conn.resp_body)
    end

    test "verify user test", %{conn: conn} do
      # create a new user
      phone = "9090909091"
      post(conn, Routes.account_path(conn, :create, %{phone: phone}))
      # fetch the details then validate it
      %User{otp: otp} = Accounts.get_user_by(%{phone: phone})

      # login API
      conn = post(conn, Routes.account_path(conn, :login, %{"phone" => phone, "otp" => otp}))
      assert conn.status == 200
    end
  end
end
