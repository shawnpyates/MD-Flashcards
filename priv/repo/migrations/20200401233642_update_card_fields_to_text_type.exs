defmodule MdFlashcards.Repo.Migrations.UpdateCardFieldsToTextType do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      modify :question, :text
      modify :answer, :text
    end
  end
end
