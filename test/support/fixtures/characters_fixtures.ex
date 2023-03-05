defmodule Dndstore.CharactersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dndstore.Characters` context.
  """

  @doc """
  Generate a character.
  """
  def character_fixture(attrs \\ %{}) do
    {:ok, character} =
      attrs
      |> Enum.into(%{
        charisma: 16,
        constitution: 16,
        dexterity: 16,
        intelligence: 16,
        name: "some name",
        strength: 16,
        wisdom: 16,
        user_id: "1"
      })
      |> Dndstore.Characters.create_character()

    character
  end
end
