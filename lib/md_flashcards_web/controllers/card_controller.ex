defmodule MdFlashcardsWeb.CardController do
  use MdFlashcardsWeb, :controller

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.Card

  action_fallback MdFlashcardsWeb.FallbackController

  plug MdFlashcardsWeb.Plugs.RequireAuth when action not in [:get_by_card_set]

  def get_by_card_set(conn, _params) do
    cards = Flashcards.list_cards_by_card_set(conn.params["card_set_id"])
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    with {:ok, %Card{} = card} <- Flashcards.create_card(card_params) do
      conn
      |> put_status(:created)
      |> render("show.json", card: card)
    end
  end

  def bulk_create(conn, %{"cards" => cards}) do
    with {_result, _} <- Flashcards.bulk_create_cards(cards, conn.params["card_set_id"]) do
      all_cards = Flashcards.list_cards_by_card_set(conn.params["card_set_id"])
      render(conn, "index.json", cards: all_cards)
    end
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Flashcards.get_card!(id)

    with {:ok, %Card{} = card} <- Flashcards.update_card(card, card_params) do
      cards = Flashcards.list_cards_by_card_set(card.card_set_id)
      render(conn, "index.json", cards: cards)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Flashcards.get_card!(id)

    with {:ok, %Card{}} <- Flashcards.delete_card(card) do
      cards = Flashcards.list_cards_by_card_set(card.card_set_id)
      render(conn, "index.json", cards: cards)
    end
  end
end
