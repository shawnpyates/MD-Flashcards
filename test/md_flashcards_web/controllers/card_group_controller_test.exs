defmodule MdFlashcardsWeb.CardGroupControllerTest do
  use MdFlashcardsWeb.ConnCase

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Flashcards.CardGroup
  alias MdFlashcards.Accounts.User

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:card_group) do
    {:ok, card_group} = Flashcards.create_card_group(@create_attrs)
    card_group
  end

  setup %{conn: conn} do
    {:ok,
     conn:
       put_req_header(conn, "accept", "application/json")
       |> assign(:user, %User{id: 1})}
  end

  describe "index" do
    test "lists all card_groups", %{conn: conn} do
      conn = get(conn, Routes.user_card_group_path(conn, :index, 1))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create card_group" do
    test "renders card_group when data is valid", %{conn: conn} do
      conn = post(conn, Routes.card_group_path(conn, :create), card_group: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.card_group_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.card_group_path(conn, :create), card_group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update card_group" do
    setup [:create_card_group]

    test "renders card_group when data is valid", %{
      conn: conn,
      card_group: %CardGroup{id: id} = card_group
    } do
      conn =
        put(conn, Routes.card_group_path(conn, :update, card_group), card_group: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.card_group_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, card_group: card_group} do
      conn =
        put(conn, Routes.card_group_path(conn, :update, card_group), card_group: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete card_group" do
    setup [:create_card_group]

    test "deletes chosen card_group", %{conn: conn, card_group: card_group} do
      conn = delete(conn, Routes.card_group_path(conn, :delete, card_group))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.card_group_path(conn, :show, card_group))
      end
    end
  end

  defp create_card_group(_) do
    card_group = fixture(:card_group)
    {:ok, card_group: card_group}
  end
end
