defmodule MisoboWeb.UserControllerTest do
  @moduledoc """
  This module tests the account controller logic
  """
  use MisoboWeb.ConnCase, async: true

  alias Misobo.Accounts
  alias Misobo.Accounts.User

  describe "user account onboarding" do
    test "signup test", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create, %{phone: "9090909090"}))
      assert conn.status == 201
      assert %{"data" => "user created successfully"} == Jason.decode!(conn.resp_body)
    end

    test "verify user test", %{conn: conn} do
      # create a new user
      phone = "9090909091"
      post(conn, Routes.user_path(conn, :create, %{phone: phone}))
      # fetch the details then validate it
      %User{otp: otp} = Accounts.get_user_by(%{phone: phone})

      # login API
      conn = post(conn, Routes.user_path(conn, :login, %{"phone" => phone, "otp" => otp}))
      assert conn.status == 200
    end

    test "verify fails when OTP is wrong", %{conn: conn} do
      # create a new user
      phone = "9090909092"
      post(conn, Routes.user_path(conn, :create, %{phone: phone}))
      # fetch the details then validate it
      %User{otp: otp} = Accounts.get_user_by(%{phone: phone})

      # login API
      conn = post(conn, Routes.user_path(conn, :login, %{"phone" => phone, "otp" => otp + 1}))
      assert conn.status == 400
    end
  end
end
