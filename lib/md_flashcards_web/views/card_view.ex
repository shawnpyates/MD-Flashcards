defmodule MdFlashcardsWeb.CardView do
  use MdFlashcardsWeb, :view
  alias MdFlashcardsWeb.CardView

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, CardView, "card.json")}
  end

  def render("card.json", %{card: card}) do
    %{id: card.id, question: card.question, answer: card.answer, card_set_id: card.card_set_id}
  end
end
