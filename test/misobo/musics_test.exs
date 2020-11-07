defmodule Misobo.MusicsTest do
  use Misobo.DataCase

  alias Misobo.Musics

  describe "musics" do
    alias Misobo.Musics.Music

    @valid_attrs %{author_name: "some author_name", duration: 42, hls_url: "some hls_url", karma: 42, production_name: "some production_name", title: "some title", url: "some url"}
    @update_attrs %{author_name: "some updated author_name", duration: 43, hls_url: "some updated hls_url", karma: 43, production_name: "some updated production_name", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{author_name: nil, duration: nil, hls_url: nil, karma: nil, production_name: nil, title: nil, url: nil}

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
end
