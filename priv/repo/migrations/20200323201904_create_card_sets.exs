defmodule MdFlashcards.Repo.Migrations.CreateCardSets do
  use Ecto.Migration

  def change do
    create table(:card_sets) do
      add :name, :string
      add :card_group_id, references(:card_groups, on_delete: :delete_all)

      timestamps()
    end

    create index(:card_sets, [:card_group_id])
  end
end
