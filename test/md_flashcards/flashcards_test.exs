defmodule MdFlashcards.FlashcardsTest do
  use MdFlashcards.DataCase

  alias MdFlashcards.Flashcards
  alias MdFlashcards.Accounts

  describe "card_groups" do
    alias MdFlashcards.Flashcards.CardGroup

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def card_group_fixture(attrs \\ %{}) do
      {:ok, card_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Flashcards.create_card_group()

      card_group
    end

    defp drop_card_sets(record) do
      record |> Map.from_struct() |> Map.drop([:card_sets])
    end

    test "list_card_groups/0 returns all card_groups" do
      user = Accounts.create_user(%{ name: "x", provider: "y", token: "z", email: "a@b.com"})
      card_group = card_group_fixture(%{user_id: user.id})
      assert Flashcards.list_card_groups(user.id) == [card_group]
    end

    test "get_card_group!/1 returns the card_group with given id" do
      card_group = card_group_fixture() |> drop_card_sets()
      assert Flashcards.get_card_group!(card_group.id) |> drop_card_sets() == card_group
    end

    test "create_card_group/1 with valid data creates a card_group" do
      assert {:ok, %CardGroup{} = card_group} = Flashcards.create_card_group(@valid_attrs)
      assert card_group.name == "some name"
    end

    test "create_card_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flashcards.create_card_group(@invalid_attrs)
    end

    test "update_card_group/2 with valid data updates the card_group" do
      card_group = card_group_fixture()

      assert {:ok, %CardGroup{} = card_group} =
               Flashcards.update_card_group(card_group, @update_attrs)

      assert card_group.name == "some updated name"
    end

    test "update_card_group/2 with invalid data returns error changeset" do
      card_group = card_group_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Flashcards.update_card_group(card_group, @invalid_attrs)

      updated_card_group = card_group |> drop_card_sets()
      assert updated_card_group == Flashcards.get_card_group!(card_group.id) |> drop_card_sets()
    end

    test "delete_card_group/1 deletes the card_group" do
      card_group = card_group_fixture()
      assert {:ok, %CardGroup{}} = Flashcards.delete_card_group(card_group)
      assert_raise Ecto.NoResultsError, fn -> Flashcards.get_card_group!(card_group.id) end
    end

    test "change_card_group/1 returns a card_group changeset" do
      card_group = card_group_fixture()
      assert %Ecto.Changeset{} = Flashcards.change_card_group(card_group)
    end
  end

  describe "card_sets" do
    alias MdFlashcards.Flashcards.CardSet

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def card_set_fixture(attrs \\ %{}) do
      {:ok, card_set} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Flashcards.create_card_set()

      {:ok, _card} =
        %{question: "q", answer: "a", card_set_id: card_set.id}
        |> Flashcards.create_card()

      card_set
    end

    defp drop_properties(record) do
      record |> Map.from_struct() |> Map.drop([:card_group, :cards])
    end

    test "list_card_sets/2 returns all card_sets" do
      card_set = card_set_fixture() |> drop_properties()
      result = Flashcards.list_card_sets("0", "")
      updated_result = List.first(result.entries) |> drop_properties()
      assert [updated_result] == [card_set]
    end

    test "get_card_set!/1 returns the card_set with given id" do
      card_set = card_set_fixture() |> drop_properties()
      result = Flashcards.get_card_set!(card_set.id) |> drop_properties()
      assert result == card_set
    end

    test "create_card_set/1 with valid data creates a card_set" do
      assert {:ok, %CardSet{} = card_set} = Flashcards.create_card_set(@valid_attrs)
      assert card_set.name == "some name"
    end

    test "create_card_set/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flashcards.create_card_set(@invalid_attrs)
    end

    test "update_card_set/2 with valid data updates the card_set" do
      card_set = card_set_fixture()
      assert {:ok, %CardSet{} = card_set} = Flashcards.update_card_set(card_set, @update_attrs)
      assert card_set.name == "some updated name"
    end

    test "update_card_set/2 with invalid data returns error changeset" do
      card_set = card_set_fixture()
      assert {:error, %Ecto.Changeset{}} = Flashcards.update_card_set(card_set, @invalid_attrs)
      updated_card_set = card_set |> drop_properties()
      result = Flashcards.get_card_set!(card_set.id) |> drop_properties()
      assert updated_card_set == result
    end

    test "delete_card_set/1 deletes the card_set" do
      card_set = card_set_fixture()
      assert {:ok, %CardSet{}} = Flashcards.delete_card_set(card_set)
      assert_raise Ecto.NoResultsError, fn -> Flashcards.get_card_set!(card_set.id) end
    end

    test "change_card_set/1 returns a card_set changeset" do
      card_set = card_set_fixture()
      assert %Ecto.Changeset{} = Flashcards.change_card_set(card_set)
    end
  end

  describe "cards" do
    alias MdFlashcards.Flashcards.Card

    @valid_attrs %{answer: "some answer", question: "some question"}
    @update_attrs %{answer: "some updated answer", question: "some updated question"}
    @invalid_attrs %{answer: nil, question: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card_set} = Flashcards.create_card_set(%{name: "x"})
      new_valid_attrs = @valid_attrs |> Map.put(:card_set_id, card_set.id)

      {:ok, card} =
        attrs
        |> Enum.into(new_valid_attrs)
        |> Flashcards.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Flashcards.list_cards(card.card_set_id) == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Flashcards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Flashcards.create_card(@valid_attrs)
      assert card.answer == "some answer"
      assert card.question == "some question"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Flashcards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, %Card{} = card} = Flashcards.update_card(card, @update_attrs)
      assert card.answer == "some updated answer"
      assert card.question == "some updated question"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Flashcards.update_card(card, @invalid_attrs)
      assert card == Flashcards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Flashcards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Flashcards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Flashcards.change_card(card)
    end
  end
end
