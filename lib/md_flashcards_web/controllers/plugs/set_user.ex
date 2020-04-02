defmodule MdFlashcardsWeb.Plugs.SetUser do
  import Plug.Conn

  import Ecto.Query, warn: false

  alias MdFlashcards.Accounts.User
  alias MdFlashcards.Flashcards.CardGroup
  alias MdFlashcards.Repo

  def init(_attrs) do
  end

  def call(conn, _attrs) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.one from(
        u in User,
        where: u.id == ^user_id,
        preload: [
          card_groups: ^Ecto.Query.from(c in CardGroup, preload: [:card_sets])
        ]
      ) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end
