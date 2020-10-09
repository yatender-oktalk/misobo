defmodule MisoboWeb.HealthController do
  use MisoboWeb, :controller
  alias Ecto.Adapters.SQL
  alias Misobo.Repo

  def index(conn, _params) do
    data = %{
      version: Application.spec(:misobo, :vsn) |> to_string(),
      application_status: ":ok",
      database_status: db_health()
    }

    response(conn, 200, data)
  end

  @doc """
  method to do raw query to db so that we can get status of it and take desicions of application health
    Note:
      * This method will return :down when database is not available
      * This method will return :up when database is available
  """
  def db_health do
    {:ok, _map} = SQL.query(Repo, "SELECT 1", [])
    :up
  rescue
    _e in DBConnection.ConnectionError -> :down
  end

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
