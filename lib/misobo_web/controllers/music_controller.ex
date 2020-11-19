defmodule MisoboWeb.MusicController do
  use MisoboWeb, :controller

  alias Misobo.Musics
  alias Misobo.Musics.Music

  def track_user_music_progress(
        conn,
        %{"id" => id, "user_id" => user_id, "progress" => progress} = _params
      ) do
    case Musics.track_user_music_progress(id, user_id, progress) do
      {:ok, data} ->
        response(conn, 200, %{data: data})

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def index(conn, %{"page" => page} = _params) do
    data = Musics.list_musics_paginated(page)
    response(conn, 200, Map.from_struct(data))
  end

  def show(conn, %{"id" => id} = _params) do
    data = Musics.get_music!(id)

    case data do
      %Music{} -> response(conn, 200, %{data: data})
      _ -> response(conn, 404, "invalid music id")
    end
  end

  # Private functions
  defp error_response(conn, status, message) do
    data = %{data: message}
    response(conn, status, data)
  end

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
