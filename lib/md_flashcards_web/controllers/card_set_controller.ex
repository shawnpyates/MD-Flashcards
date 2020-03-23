defmodule MdFlashcardsWeb.CardSetController do
  use MdFlashcardsWeb, :controller

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.CardSet

  action_fallback MdFlashcardsWeb.FallbackController

  def index(conn, _params) do
    card_sets = Flashcards.list_card_sets()
    render(conn, "index.json", card_sets: card_sets)
  end

  def create(conn, %{"card_set" => card_set_params}) do
    with {:ok, %CardSet{} = card_set} <- Flashcards.create_card_set(card_set_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.card_set_path(conn, :show, card_set))
      |> render("show.json", card_set: card_set)
    end
  end

  def show(conn, %{"id" => id}) do
    card_set = Flashcards.get_card_set!(id)
    render(conn, "show.json", card_set: card_set)
  end

  def update(conn, %{"id" => id, "card_set" => card_set_params}) do
    card_set = Flashcards.get_card_set!(id)

    with {:ok, %CardSet{} = card_set} <- Flashcards.update_card_set(card_set, card_set_params) do
      render(conn, "show.json", card_set: card_set)
    end
  end

  def delete(conn, %{"id" => id}) do
    card_set = Flashcards.get_card_set!(id)

    with {:ok, %CardSet{}} <- Flashcards.delete_card_set(card_set) do
      send_resp(conn, :no_content, "")
    end
  end
end
