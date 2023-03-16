defmodule Dndstore.CharactersTest do
  use Dndstore.DataCase

  alias Dndstore.Characters

  describe "characters" do
    alias Dndstore.Characters.Character

    import Dndstore.AccountsFixtures
    import Dndstore.CharactersFixtures

    setup do
      %{user: user_fixture()}
    end

    @invalid_attrs %{
      charisma: nil,
      constitution: nil,
      dexterity: nil,
      intelligence: nil,
      name: nil,
      level: nil
      strength: nil,
      wisdom: nil
    }

    test "list_characters/1 returns all characters", %{user: user} do
      character = character_fixture(user)
      assert Characters.list_characters(user) == [character]
    end

    test "get_character!/1 returns the character with given id", %{user: user} do
      character = character_fixture(user)
      assert Characters.get_character(user, character.id) == character
    end

    test "create_character/1 with valid data creates a character", %{user: user} do
      valid_attrs = %{
        charisma: 16,
        constitution: 16,
        dexterity: 16,
        intelligence: 16,
        name: "some name",
        level: 16,
        strength: 16,
        wisdom: 16
      }

      assert {:ok, %Character{} = character} = Characters.create_character(user, valid_attrs)
      assert character.charisma == 16
      assert character.constitution == 16
      assert character.dexterity == 16
      assert character.intelligence == 16
      assert character.name == "some name"
      assert character.strength == 16
      assert character.wisdom == 16
    end

    test "create_character/1 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Characters.create_character(user, @invalid_attrs)
    end

    test "update_character/2 with valid data updates the character", %{user: user} do
      character = character_fixture(user)

      update_attrs = %{
        charisma: 17,
        constitution: 17,
        dexterity: 17,
        intelligence: 17,
        name: "some updated name",
        strength: 17,
        wisdom: 17
      }

      assert {:ok, %Character{} = character} =
               Characters.update_character(character, update_attrs)

      assert character.charisma == 17
      assert character.constitution == 17
      assert character.dexterity == 17
      assert character.intelligence == 17
      assert character.name == "some updated name"
      assert character.strength == 17
      assert character.wisdom == 17
    end

    test "update_character/2 with invalid data returns error changeset", %{user: user} do
      character = character_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Characters.update_character(character, @invalid_attrs)
      assert character == Characters.get_character(user, character.id)
    end

    test "delete_character/1 deletes the character", %{user: user} do
      character = character_fixture(user)
      assert {:ok, %Character{}} = Characters.delete_character(character)
      assert Characters.get_character(user, character.id) == nil
    end

    test "change_character/1 returns a character changeset", %{user: user} do
      character = character_fixture(user)
      assert %Ecto.Changeset{} = Characters.change_character(character)
    end
  end
end
