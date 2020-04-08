defmodule MdFlashcardsWeb.UserView do
  use MdFlashcardsWeb, :view
  alias MdFlashcardsWeb.UserView

  defp get_card_groups(user) do
    if Ecto.assoc_loaded?(user.card_groups) do
      Enum.map(user.card_groups, fn group ->
        Map.from_struct(group)
        |> Map.put(:card_set_length, Enum.count(group.card_sets))
        |> Map.drop([:__meta__, :user, :card_sets])
      end)
    else
      nil
    end
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      card_groups: get_card_groups(user)
    }
  end
end
