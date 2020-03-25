defmodule MdFlashcards.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(email provider token)a
  @optional_fields ~w(name)a

  schema "users" do
    field :email, :string
    field :name, :string
    field :provider, :string
    field :token, :string

    has_many :card_groups, MdFlashcards.Flashcards.CardGroup

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
