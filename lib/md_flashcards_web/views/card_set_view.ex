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

  defp get_creator_name(set) do
    if Ecto.assoc_loaded?(set.card_group) do
      set.card_group.user.name
    else
      nil
    end
  end

  defp get_creator_id(set) do
    if Ecto.assoc_loaded?(set.card_group) do
      set.card_group && set.card_group.user_id
    else
      nil
    end
  end

  def render("index.json", %{result: %{entries: card_sets, metadata: metadata}}) do
    %{
      data: render_many(card_sets, CardSetView, "card_set_index.json"),
      metadata: %{cursor_after: metadata.after}
    }
  end

  def render("show.json", %{card_set: card_set}) do
    %{data: render_one(card_set, CardSetView, "card_set_show.json")}
  end

  def render("card_set_index.json", %{card_set: card_set}) do
    %{
      id: card_set.id,
      name: card_set.name,
      card_group_id: card_set.card_group_id,
      inserted_at: card_set.inserted_at,
      card_length: Enum.count(card_set.cards),
      creator_name: get_creator_name(card_set)
    }
  end

  def render("card_set_show.json", %{card_set: card_set}) do
    %{
      id: card_set.id,
      name: card_set.name,
      creator_id: get_creator_id(card_set),
      cards: get_cards(card_set)
    }
  end
end
