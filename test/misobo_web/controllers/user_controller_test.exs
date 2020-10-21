defmodule MisoboWeb.UserControllerTest do
  @moduledoc """
  This module tests the account controller logic
  """
  use MisoboWeb.ConnCase, async: true

  alias Misobo.Accounts
  alias Misobo.Accounts.User

  describe "user account onboarding" do
    setup %{conn: conn} do
      device_id = Ecto.UUID.generate()
      # create a new registration
      response = post(conn, Routes.registration_path(conn, :create, %{device_id: device_id}))
      %{"data" => %{"token" => token}} = Jason.decode!(response.resp_body)
      {:ok, conn: put_req_header(conn, "token", token)}
    end

    test "signup test", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create, %{phone: "9090909090"}))
      assert conn.status == 201

      assert %{
               "data" => %{
                 "dob" => nil,
                 "horoscope_id" => nil,
                 "id" => id,
                 "is_enabled" => false,
                 "karma_points" => 0,
                 "name" => nil,
                 "phone" => "9090909090"
               }
             } = Jason.decode!(conn.resp_body)
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
