defmodule MdFlashcardsWeb.UserView do
  use MdFlashcardsWeb, :view
  alias MdFlashcardsWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      token: user.token,
      card_groups:  Enum.map(user.card_groups, fn group ->
        Map.from_struct(group)
        |> Map.drop([:__meta__, :user, :card_sets])
      end)
    }
  end
end
