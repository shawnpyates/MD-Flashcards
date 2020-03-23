defmodule MdFlashcards.Flashcards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(answer question card_set_id)a
  schema "cards" do
    field :answer, :string
    field :question, :string

    belongs_to :card_set, MdFlashcards.Flashcards.CardSet

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, @required_fields)
    |> validate_required([:question, :answer])
  end
end
