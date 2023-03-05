defmodule Dndstore.CharactersTest do
  use Dndstore.DataCase

  alias Dndstore.Characters

  describe "characters" do
    alias Dndstore.Characters.Character

    import Dndstore.CharactersFixtures

    @invalid_attrs %{
      charisma: nil,
      constitution: nil,
      dexterity: nil,
      intelligence: nil,
      name: nil,
      strength: nil,
      wisdom: nil
    }

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Characters.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Characters.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      valid_attrs = %{
        charisma: 42,
        constitution: 42,
        dexterity: 42,
        intelligence: 42,
        name: "some name",
        strength: 42,
        wisdom: 42
      }

      assert {:ok, %Character{} = character} = Characters.create_character(valid_attrs)
      assert character.charisma == 42
      assert character.constitution == 42
      assert character.dexterity == 42
      assert character.intelligence == 42
      assert character.name == "some name"
      assert character.strength == 42
      assert character.wisdom == 42
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Characters.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()

      update_attrs = %{
        charisma: 43,
        constitution: 43,
        dexterity: 43,
        intelligence: 43,
        name: "some updated name",
        strength: 43,
        wisdom: 43
      }

      assert {:ok, %Character{} = character} =
               Characters.update_character(character, update_attrs)

      assert character.charisma == 43
      assert character.constitution == 43
      assert character.dexterity == 43
      assert character.intelligence == 43
      assert character.name == "some updated name"
      assert character.strength == 43
      assert character.wisdom == 43
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Characters.update_character(character, @invalid_attrs)
      assert character == Characters.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Characters.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Characters.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Characters.change_character(character)
    end
  end
end
