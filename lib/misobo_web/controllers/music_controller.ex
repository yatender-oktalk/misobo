defmodule MisoboWeb.MusicController do
  use MisoboWeb, :controller

  alias Misobo.Musics

  def track_user_music_progress(
        conn,
        %{"id" => id, "user_id" => user_id, "progress" => progress} = params
      ) do
    with {:ok, data} <- Musics.track_user_music_progress(id, user_id, progress) do
      response(conn, 200, %{data: data})
    else
      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
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
