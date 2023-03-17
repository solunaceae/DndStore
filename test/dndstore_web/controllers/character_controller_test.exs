defmodule DndstoreWeb.CharacterControllerTest do
  use DndstoreWeb.ConnCase

  import Dndstore.CharactersFixtures

  @create_attrs %{
    charisma: 16,
    constitution: 16,
    dexterity: 16,
    intelligence: 16,
    name: "some name",
    level: 16,
    strength: 16,
    wisdom: 16
  }
  @update_attrs %{
    charisma: 17,
    constitution: 17,
    dexterity: 17,
    intelligence: 17,
    name: "some updated name",
    level: 16,
    strength: 17,
    wisdom: 17
  }
  @invalid_attrs %{
    charisma: nil,
    constitution: nil,
    dexterity: nil,
    intelligence: nil,
    name: nil,
    level: nil,
    strength: nil,
    wisdom: nil
  }

  setup :register_and_log_in_user

  describe "index" do
    test "lists all characters", %{conn: conn} do
      conn = get(conn, ~p"/characters")
      assert html_response(conn, 200) =~ "Listing Characters"
    end
  end

  describe "new character" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/characters/new")
      assert html_response(conn, 200) =~ "New Character"
    end
  end

  describe "create character" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/characters", character: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/characters/#{id}"

      conn = get(conn, ~p"/characters/#{id}")
      assert html_response(conn, 200) =~ "Character #{@create_attrs.name}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/characters", character: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Character"
    end
  end

  describe "edit character" do
    setup [:register_and_log_in_user, :create_character]

    test "renders form for editing chosen character", %{conn: conn, character: character} do
      conn = get(conn, ~p"/characters/#{character}/edit")
      assert html_response(conn, 200) =~ "Editing #{@create_attrs.name}"
    end
  end

  describe "update character" do
    setup [:create_character]

    test "redirects when data is valid", %{conn: conn, character: character} do
      conn = put(conn, ~p"/characters/#{character}", character: @update_attrs)
      assert redirected_to(conn) == ~p"/characters/#{character}"

      conn = get(conn, ~p"/characters/#{character}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, character: character} do
      conn = put(conn, ~p"/characters/#{character}", character: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Character"
    end
  end

  describe "delete character" do
    setup [:create_character]

    test "deletes chosen character", %{conn: conn, character: character} do
      conn = delete(conn, ~p"/characters/#{character}")
      assert redirected_to(conn) == ~p"/characters"
    end
  end

  defp create_character(%{user: user}) do
    character = character_fixture(user)
    %{character: character}
  end
end
