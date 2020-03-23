defmodule MdFlashcards.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :question, :string
      add :answer, :string
      add :card_set_id, references(:card_sets, on_delete: :delete_all)

      timestamps()
    end

    create index(:cards, [:card_set_id])
  end
end
