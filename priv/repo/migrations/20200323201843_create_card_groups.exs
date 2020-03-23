defmodule MdFlashcards.Repo.Migrations.CreateCardGroups do
  use Ecto.Migration

  def change do
    create table(:card_groups) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:card_groups, [:user_id])
  end
end
