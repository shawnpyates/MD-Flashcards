defmodule MdFlashcardsWeb.CardSetView do
  use MdFlashcardsWeb, :view
  alias MdFlashcardsWeb.CardSetView

  defp get_cards(set) do
    if Ecto.assoc_loaded?(set.cards) do
      Enum.map(set.cards, fn card ->
        Map.from_struct(card)
        |> Map.drop([:__meta__, :card_set])
      end)
    else
      nil
    end
  end

  def render("index.json", %{card_sets: card_sets}) do
    %{data: render_many(card_sets, CardSetView, "card_set.json")}
  end

  def render("show.json", %{card_set: card_set}) do
    %{data: render_one(card_set, CardSetView, "card_set.json")}
  end

  def render("card_set.json", %{card_set: card_set}) do
    %{id: card_set.id,
      name: card_set.name,
      card_group_id: card_set.card_group_id,
      cards: get_cards(card_set)
    }
  end
end
