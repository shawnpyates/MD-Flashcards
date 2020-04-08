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
    card_group_query = from(
      g in CardGroup,
      order_by: [desc: g.inserted_at],
      preload: [:card_sets]
    )

    cond do
      user = user_id && Repo.one from(
        u in User,
        where: u.id == ^user_id,
        preload: [
          card_groups: ^card_group_query
        ]
      ) ->
        assign(conn, :user, user)
      true ->
        cond do
          conn.assigns[:user] -> conn
          true -> assign(conn, :user, nil)
        end
    end
  end
end
