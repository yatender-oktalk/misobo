defmodule Misobo.MusicsTest do
  use Misobo.DataCase

  alias Misobo.Musics

  describe "musics" do
    alias Misobo.Musics.Music

    @valid_attrs %{
      author_name: "some author_name",
      duration: 42,
      hls_url: "some hls_url",
      karma: 42,
      production_name: "some production_name",
      title: "some title",
      url: "some url"
    }
    @update_attrs %{
      author_name: "some updated author_name",
      duration: 43,
      hls_url: "some updated hls_url",
      karma: 43,
      production_name: "some updated production_name",
      title: "some updated title",
      url: "some updated url"
    }
    @invalid_attrs %{
      author_name: nil,
      duration: nil,
      hls_url: nil,
      karma: nil,
      production_name: nil,
      title: nil,
      url: nil
    }

    def music_fixture(attrs \\ %{}) do
      {:ok, music} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Musics.create_music()

      music
    end

    test "list_musics/0 returns all musics" do
      music = music_fixture()
      assert Musics.list_musics() == [music]
    end

    test "get_music!/1 returns the music with given id" do
      music = music_fixture()
      assert Musics.get_music!(music.id) == music
    end

    test "create_music/1 with valid data creates a music" do
      assert {:ok, %Music{} = music} = Musics.create_music(@valid_attrs)
      assert music.author_name == "some author_name"
      assert music.duration == 42
      assert music.hls_url == "some hls_url"
      assert music.karma == 42
      assert music.production_name == "some production_name"
      assert music.title == "some title"
      assert music.url == "some url"
    end

    test "create_music/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Musics.create_music(@invalid_attrs)
    end

    test "update_music/2 with valid data updates the music" do
      music = music_fixture()
      assert {:ok, %Music{} = music} = Musics.update_music(music, @update_attrs)
      assert music.author_name == "some updated author_name"
      assert music.duration == 43
      assert music.hls_url == "some updated hls_url"
      assert music.karma == 43
      assert music.production_name == "some updated production_name"
      assert music.title == "some updated title"
      assert music.url == "some updated url"
    end

    test "update_music/2 with invalid data returns error changeset" do
      music = music_fixture()
      assert {:error, %Ecto.Changeset{}} = Musics.update_music(music, @invalid_attrs)
      assert music == Musics.get_music!(music.id)
    end

    test "delete_music/1 deletes the music" do
      music = music_fixture()
      assert {:ok, %Music{}} = Musics.delete_music(music)
      assert_raise Ecto.NoResultsError, fn -> Musics.get_music!(music.id) end
    end

    test "change_music/1 returns a music changeset" do
      music = music_fixture()
      assert %Ecto.Changeset{} = Musics.change_music(music)
    end
  end

  describe "user_music_progress" do
    alias Misobo.Musics.UserMusicProgress

    @valid_attrs %{progress: 42}
    @update_attrs %{progress: 43}
    @invalid_attrs %{progress: nil}

    def user_music_progress_fixture(attrs \\ %{}) do
      {:ok, user_music_progress} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Musics.create_user_music_progress()

      user_music_progress
    end

    test "list_user_music_progress/0 returns all user_music_progress" do
      user_music_progress = user_music_progress_fixture()
      assert Musics.list_user_music_progress() == [user_music_progress]
    end

    test "get_user_music_progress!/1 returns the user_music_progress with given id" do
      user_music_progress = user_music_progress_fixture()
      assert Musics.get_user_music_progress!(user_music_progress.id) == user_music_progress
    end

    test "create_user_music_progress/1 with valid data creates a user_music_progress" do
      assert {:ok, %UserMusicProgress{} = user_music_progress} =
               Musics.create_user_music_progress(@valid_attrs)

      assert user_music_progress.progress == 42
    end

    test "create_user_music_progress/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Musics.create_user_music_progress(@invalid_attrs)
    end

    test "update_user_music_progress/2 with valid data updates the user_music_progress" do
      user_music_progress = user_music_progress_fixture()

      assert {:ok, %UserMusicProgress{} = user_music_progress} =
               Musics.update_user_music_progress(user_music_progress, @update_attrs)

      assert user_music_progress.progress == 43
    end

    test "update_user_music_progress/2 with invalid data returns error changeset" do
      user_music_progress = user_music_progress_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Musics.update_user_music_progress(user_music_progress, @invalid_attrs)

      assert user_music_progress == Musics.get_user_music_progress!(user_music_progress.id)
    end

    test "delete_user_music_progress/1 deletes the user_music_progress" do
      user_music_progress = user_music_progress_fixture()
      assert {:ok, %UserMusicProgress{}} = Musics.delete_user_music_progress(user_music_progress)

      assert_raise Ecto.NoResultsError, fn ->
        Musics.get_user_music_progress!(user_music_progress.id)
      end
    end

    test "change_user_music_progress/1 returns a user_music_progress changeset" do
      user_music_progress = user_music_progress_fixture()
      assert %Ecto.Changeset{} = Musics.change_user_music_progress(user_music_progress)
    end
  end
end
