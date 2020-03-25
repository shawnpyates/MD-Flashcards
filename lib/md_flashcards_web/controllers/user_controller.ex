defmodule MdFlashcardsWeb.UserController do
  use MdFlashcardsWeb, :controller
  plug Ueberauth

  alias MdFlashcards.Accounts
  alias MdFlashcards.Accounts.User
  alias MdFlashcards.Repo

  action_fallback MdFlashcardsWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _attrs) do
    user_attrs = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_attrs)

    signin(conn, changeset)
  end

  def signout(conn, _attrs) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.user_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case Accounts.insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> render("show.json", user: user |> Repo.preload(:card_groups))
      {:error, _reason} ->
        conn
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end
end
