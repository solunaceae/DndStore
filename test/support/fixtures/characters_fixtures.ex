defmodule Dndstore.CharactersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dndstore.Characters` context.
  """

  alias Dndstore.Accounts.User

  @doc """
  Generate a character.
  """
  def character_fixture(%User{} = user, attrs \\ %{}) do
    character =
      attrs
      |> Enum.into(%{
        charisma: 16,
        constitution: 16,
        dexterity: 16,
        intelligence: 16,
        name: "some name",
        level: 16,
        strength: 16,
        wisdom: 16
      })

    {:ok, character} = Dndstore.Characters.create_character(user, character)

    character
  end
end
