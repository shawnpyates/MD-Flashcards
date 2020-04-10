defmodule MdFlashcardsWeb.Plugs.SetUser do
  import Plug.Conn

  import Ecto.Query, warn: false

  alias MdFlashcards.Accounts.User
  alias MdFlashcards.Repo

  def init(_attrs) do
  end

  def call(conn, _attrs) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get!(User, user_id) ->
        assign(conn, :user, user)

      true ->
        cond do
          conn.assigns[:user] -> conn
          true -> assign(conn, :user, nil)
        end
    end
  end
end
