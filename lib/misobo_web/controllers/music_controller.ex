defmodule MisoboWeb.MusicController do
  use MisoboWeb, :controller

  alias Misobo.Musics
  alias Misobo.Musics.Music
  alias Misobo.Accounts.User

  def track_user_music_progress(
        conn,
        %{"id" => id, "user_id" => user_id, "progress" => progress} = _params
      ) do
    case Musics.track_user_music_progress(String.to_integer(id), user_id, progress) do
      {:ok, data} ->
        {:karma_points, status} = Misobo.Karmas.handle_karma_points(user_id, id, progress)

        response(conn, 200, %{data: data, points_aquired: status})

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def index(
        %{
          assigns: %{
            user: %User{
              id: user_id,
              is_mind_pack_unlocked: is_mind_pack_unlocked,
              is_body_pack_unlocked: is_body_pack_unlocked
            }
          }
        } = conn,
        %{"page" => page} = _params
      ) do
    entries =
      page
      |> Musics.list_musics_paginated(is_mind_pack_unlocked, is_body_pack_unlocked)
      |> Map.from_struct()

    entry_data = Musics.add_user_musics_progress(entries, user_id)

    data = Map.put(entries, :entries, entry_data)

    response(conn, 200, data)
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
