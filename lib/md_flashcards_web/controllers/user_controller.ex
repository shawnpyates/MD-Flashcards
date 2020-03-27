defmodule MdFlashcardsWeb.UserController do
  use MdFlashcardsWeb, :controller
  plug Ueberauth

  alias MdFlashcards.Accounts
  alias MdFlashcards.Accounts.User

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

  def get_current(conn, _attrs) do
    conn
    |> put_resp_header("Access-Control-Allow-Credentials", "true")
    |> render("show.json", user: conn.assigns.user)
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _attrs) do
    user_attrs = %{
      token: auth.credentials.token,
      email: auth.info.email,
      name: auth.info.name,
      provider: "github"
    }
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
        |> put_session(:user_id, user.id)
        |> redirect(external: "http://localhost:3000/auth/#{user.id}")
      {:error, _reason} ->
        conn
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end
end
