defmodule MisoboWeb.RegistrationControllerTest do
  @moduledoc """
  This module tests the registration controller logic
  """
  use MisoboWeb.ConnCase, async: false

  describe "Registration" do
    test "Create a new registration", %{conn: conn} do
      # create a new registration
      response = post(conn, Routes.registration_path(conn, :create, %{device_id: "abc1234"}))

      assert %{
               "data" => %{
                 "id" => id,
                 "msg" => "user registered successfully",
                 "token" => token
               }
             } = Jason.decode!(response.resp_body)

      assert response.status == 201
    end

    test "new registration generates a valid token", %{conn: conn} do
      # create a new registration
      response = post(conn, Routes.registration_path(conn, :create, %{device_id: "abdlkfjslk"}))

      assert %{
               "data" => %{
                 "token" => token
               }
             } = Jason.decode!(response.resp_body)

      assert {:ok, data} = Misobo.Authentication.verify(token)
    end
  end
end
