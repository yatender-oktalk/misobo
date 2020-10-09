defmodule MisoboWeb.DbHealthPlug do
  @moduledoc """
  This plug is written to show service unavailable error
  in first call only we will check that if our DB service is up or down
  if our service is down then we will return connection from here.
  """
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]
  alias MisoboWeb.HealthController

  def init(defaults) do
    defaults
  end

  @doc """
  This module accepts conn and assigns health key.
  In case Database is not avaible we will halt request here.
  """
  def call(conn, _defaults) do
    # Health Controller is checking for health of our db.
    case HealthController.db_health() do
      :down ->
        conn
        |> put_status(503)
        |> json("database unavailable")
        |> halt

      _ ->
        conn |> assign(:health, :ok)
    end
  end
end
