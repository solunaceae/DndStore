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
        charisma: 42,
        constitution: 42,
        dexterity: 42,
        intelligence: 42,
        name: "some name",
        strength: 42,
        wisdom: 42
      })
      |> Dndstore.Characters.create_character()

    character
  end
end
