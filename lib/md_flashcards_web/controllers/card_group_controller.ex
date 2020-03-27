defmodule MdFlashcardsWeb.CardGroupController do
  use MdFlashcardsWeb, :controller

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.CardGroup

  action_fallback MdFlashcardsWeb.FallbackController

  def index(conn, _params) do
    card_groups = Flashcards.list_card_groups()
    render(conn, "index.json", card_groups: card_groups)
  end

  def create(conn, %{"card_group" => card_group_params}) do
    with {:ok, %CardGroup{} = card_group} <- Flashcards.create_card_group(card_group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.card_group_path(conn, :show, card_group))
      |> render("show.json", card_group: card_group)
    end
  end

  def show(conn, %{"id" => id}) do
    card_group = Flashcards.get_card_group!(id)
    conn
    |> put_resp_header("Access-Control-Allow-Credentials", "true")
    |> render("show.json", card_group: card_group)
  end

  def update(conn, %{"id" => id, "card_group" => card_group_params}) do
    card_group = Flashcards.get_card_group!(id)

    with {:ok, %CardGroup{} = card_group} <- Flashcards.update_card_group(card_group, card_group_params) do
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
