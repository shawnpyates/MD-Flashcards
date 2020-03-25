defmodule MdFlashcardsWeb.CardSetView do
  use MdFlashcardsWeb, :view
  alias MdFlashcardsWeb.CardSetView

  def render("index.json", %{card_sets: card_sets}) do
    %{data: render_many(card_sets, CardSetView, "card_set.json")}
  end

  def render("show.json", %{card_set: card_set}) do
    %{data: render_one(card_set, CardSetView, "card_set.json")}
  end

  def render("card_set.json", %{card_set: card_set}) do
    IO.inspect(card_set)
    %{id: card_set.id,
      name: card_set.name,
      card_group_id: card_set.card_group_id,
      cards: Enum.map(card_set.cards, fn card ->
        Map.from_struct(card)
        |> Map.drop([:__meta__, :card_set])
      end)
    }
  end
end
