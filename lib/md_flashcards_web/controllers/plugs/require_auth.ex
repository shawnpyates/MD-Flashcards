defmodule MdFlashcardsWeb.Plugs.RequireAuth do
  import Plug.Conn

  import Ecto.Query, warn: false

  def init(_attrs) do
  end

  def call(conn, _attrs) do
    cond do
      conn.assigns[:user] -> conn
      true -> conn |> send_resp(401, "Unauthorized") |> halt()
    end
  end
end
