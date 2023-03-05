defmodule Dndstore.Characters.Character do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "characters" do
    field :charisma, :integer
    field :constitution, :integer
    field :dexterity, :integer
    field :intelligence, :integer
    field :name, :string
    field :strength, :integer
    field :wisdom, :integer
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma])
    |> validate_required([:name, :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma])
    |> validate_inclusion(:charisma, 1..20)
    |> validate_inclusion(:constitution, 1..20)
    |> validate_inclusion(:dexterity, 1..20)
    |> validate_inclusion(:intelligence, 1..20)
    |> validate_inclusion(:strength, 1..20)
    |> validate_inclusion(:wisdom, 1..20)
  end
end
