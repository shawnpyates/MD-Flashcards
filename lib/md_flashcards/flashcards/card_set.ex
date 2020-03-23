defmodule MdFlashcards.Flashcards.CardSet do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(name card_group_id)a

  schema "card_sets" do
    field :name, :string

    belongs_to :card_group, MdFlashcards.Flashcards.CardGroup
    has_many :cards, MdFlashcards.Flashcards.Card

    timestamps()
  end

  @doc false
  def changeset(card_set, attrs) do
    card_set
    |> cast(attrs, @required_fields)
    |> validate_required([:name])
  end
end
