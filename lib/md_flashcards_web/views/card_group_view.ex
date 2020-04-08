defmodule MdFlashcardsWeb.CardGroupView do
  use MdFlashcardsWeb, :view
  alias MdFlashcardsWeb.CardGroupView

  defp get_sets(group) do
    if Ecto.assoc_loaded?(group.card_sets) do
      Enum.map(group.card_sets, fn set ->
        Map.from_struct(set)
        |> Map.put(:card_length, Enum.count(set.cards))
        |> Map.drop([:__meta__, :card_group, :cards])
      end)
    else
      nil
    end
  end

  def render("index.json", %{card_groups: card_groups}) do
    %{data: render_many(card_groups, CardGroupView, "card_group.json")}
  end

  def render("show.json", %{card_group: card_group}) do
    %{data: render_one(card_group, CardGroupView, "card_group.json")}
  end

  def render("card_group.json", %{card_group: card_group}) do
    %{id: card_group.id, name: card_group.name, card_sets: get_sets(card_group)}
  end
end
