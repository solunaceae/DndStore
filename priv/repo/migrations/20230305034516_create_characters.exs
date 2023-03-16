defmodule Dndstore.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :level, :integer, null: false
      add :strength, :integer, null: false
      add :dexterity, :integer, null: false
      add :constitution, :integer, null: false
      add :wisdom, :integer, null: false
      add :intelligence, :integer, null: false
      add :charisma, :integer, null: false
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:characters, [:user_id])
  end
end
