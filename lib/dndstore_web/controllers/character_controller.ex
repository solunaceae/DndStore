defmodule DndstoreWeb.CharacterController do
  use DndstoreWeb, :controller

  alias Dndstore.Characters
  alias Dndstore.Characters.Character

  def index(conn, _params) do
    characters = Characters.list_characters(conn.assigns.current_user.id)
    render(conn, :index, characters: characters)
  end

  def new(conn, _params) do
    changeset = Characters.change_character(%Character{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"character" => character_params}) do
    case Characters.create_character(conn.assigns.current_user.id, character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character created successfully.")
        |> redirect(to: ~p"/characters/#{character}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    case Characters.get_character(conn.assigns.current_user.id, id) do
      nil ->
        conn
        |> put_flash(:error, "Character not found!")
        |> redirect(to: ~p"/characters/")

      character ->
        render(conn, :show, character: character)
    end
  end

  def edit(conn, %{"id" => id}) do
    case Characters.get_character(conn.assigns.current_user.id, id) do
      nil ->
        conn
        |> put_flash(:error, "Character not found!")
        |> redirect(to: ~p"/characters/")

      character ->
        changeset = Characters.change_character(character)
        render(conn, :edit, character: character, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    case Characters.get_character(conn.assigns.current_user.id, id) do
      nil ->
        conn
        |> put_flash(:error, "Character not found!")
        |> redirect(to: ~p"/characters/")

      character ->
        case Characters.update_character(character, character_params) do
          {:ok, character} ->
            conn
            |> put_flash(:info, "Character updated successfully.")
            |> redirect(to: ~p"/characters/#{character}")

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, :edit, character: character, changeset: changeset)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    case Characters.get_character(conn.assigns.current_user.id, id) do
      nil ->
        conn
        |> put_flash(:error, "Character not found!")
        |> redirect(to: ~p"/characters/")

      character ->
        {:ok, _character} = Characters.delete_character(character)

        conn
        |> put_flash(:info, "Character deleted successfully.")
        |> redirect(to: ~p"/characters")
    end
  end
end
