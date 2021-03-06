defmodule MdFlashcardsWeb.CardGroupController do
  use MdFlashcardsWeb, :controller

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.CardGroup

  action_fallback MdFlashcardsWeb.FallbackController

  plug MdFlashcardsWeb.Plugs.RequireAuth when action in [:create, :update, :delete]

  def list_by_user(conn, %{"user_id" => user_id}) do
    card_groups = Flashcards.list_card_groups_by_user(user_id)
    render(conn, "index.json", card_groups: card_groups)
  end

  def create(conn, %{"card_group" => card_group_params}) do
    with {:ok, %CardGroup{} = card_group} <- Flashcards.create_card_group(card_group_params) do
      conn
      |> put_status(:created)
      |> render("show.json", card_group: card_group)
    end
  end

  def show(conn, %{"id" => id}) do
    card_group = Flashcards.get_card_group!(id)

    conn
    |> render("show.json", card_group: card_group)
  end

  def update(conn, %{"id" => id, "card_group" => card_group_params}) do
    card_group = Flashcards.get_card_group!(id)

    with {:ok, %CardGroup{} = card_group} <-
           Flashcards.update_card_group(card_group, card_group_params) do
      render(conn, "show.json", card_group: card_group)
    end
  end

  def delete(conn, %{"id" => id}) do
    card_group = Flashcards.get_card_group!(id)

    with {:ok, %CardGroup{}} <- Flashcards.delete_card_group(card_group) do
      send_resp(conn, :no_content, "")
    end
  end
end
