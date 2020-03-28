defmodule MdFlashcardsWeb.CardController do
  use MdFlashcardsWeb, :controller

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.Card

  action_fallback MdFlashcardsWeb.FallbackController

  def index(conn, _params) do
    cards = Flashcards.list_cards(conn.params["card_set_id"])
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    with {:ok, %Card{} = card} <- Flashcards.create_card(card_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.card_path(conn, :show, card))
      |> render("show.json", card: card)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    card = Flashcards.get_card!(id)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Flashcards.get_card!(id)

    with {:ok, %Card{} = card} <- Flashcards.update_card(card, card_params) do
      render(conn, "show.json", card: card)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Flashcards.get_card!(id)

    with {:ok, %Card{}} <- Flashcards.delete_card(card) do
      send_resp(conn, :no_content, "")
    end
  end
end
