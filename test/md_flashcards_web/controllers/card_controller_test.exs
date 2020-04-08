defmodule MdFlashcardsWeb.CardControllerTest do
  use MdFlashcardsWeb.ConnCase

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.Card
  alias MdFlashcards.Accounts.User

  @create_attrs %{
    answer: "some answer",
    question: "some question"
  }
  @update_attrs %{
    answer: "some updated answer",
    question: "some updated question"
  }
  @invalid_attrs %{answer: nil, question: nil}

  def fixture(:card) do
    {:ok, card_set} = Flashcards.create_card_set(%{name: "some name"})
    updated_create_attrs = @create_attrs |> Map.put(:card_set_id, card_set.id)
    {:ok, card} = Flashcards.create_card(updated_create_attrs)
    card
  end

  setup %{conn: conn} do
    {:ok,
      conn:
        put_req_header(conn, "accept", "application/json")
        |> assign(:user, %User{id: 1})
    }
  end

  describe "index" do
    test "lists all cards", %{conn: conn} do
      conn = get(conn, Routes.card_set_card_path(conn, :index, 1))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create card" do
    test "renders card when data is valid", %{conn: conn} do
      conn = post(conn, Routes.card_path(conn, :create), card: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.card_path(conn, :show, id))

      assert %{
               "id" => id,
               "answer" => "some answer",
               "question" => "some question"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.card_path(conn, :create), card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update card" do
    setup [:create_card]

    test "renders card when data is valid", %{conn: conn, card: %Card{id: id} = card} do
      conn = put(conn, Routes.card_path(conn, :update, card), card: @update_attrs)
      assert %{"id" => ^id} = List.first(json_response(conn, 200)["data"])

      conn = get(conn, Routes.card_path(conn, :show, id))

      assert %{
               "id" => id,
               "answer" => "some updated answer",
               "question" => "some updated question"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, card: card} do
      conn = put(conn, Routes.card_path(conn, :update, card), card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete card" do
    setup [:create_card]

    test "deletes chosen card", %{conn: conn, card: card} do
      conn = delete(conn, Routes.card_path(conn, :delete, card))
      assert response(conn, 200)

      assert_error_sent 404, fn ->
        get(conn, Routes.card_path(conn, :show, card))
      end
    end
  end

  defp create_card(_) do
    card = fixture(:card)
    {:ok, card: card}
  end
end
