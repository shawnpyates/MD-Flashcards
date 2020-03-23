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
    %{id: card_set.id,
      name: card_set.name}
  end
end
