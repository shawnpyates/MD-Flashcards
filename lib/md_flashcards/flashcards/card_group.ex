defmodule MdFlashcards.Flashcards.CardGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(name user_id)a

  schema "card_groups" do
    field :name, :string

    belongs_to :user, MdFlashcards.Accounts.User
    has_many :card_sets, MdFlashcards.Flashcards.CardSet

    timestamps()
  end

  @doc false
  def changeset(card_group, attrs) do
    card_group
    |> cast(attrs, @required_fields)
    |> validate_required([:name])
  end
end
