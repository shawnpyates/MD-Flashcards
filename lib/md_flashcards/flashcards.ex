defmodule MdFlashcards.Flashcards do
  @moduledoc """
  The Flashcards context.
  """

  import Ecto.Query, warn: false
  alias MdFlashcards.Repo

  alias MdFlashcards.Flashcards.CardGroup

  @doc """
  Returns the list of card_groups.

  ## Examples

      iex> list_card_groups()
      [%CardGroup{}, ...]

  """
  def list_card_groups do
    Repo.all(CardGroup)
  end

  @doc """
  Gets a single card_group.

  Raises `Ecto.NoResultsError` if the Card group does not exist.

  ## Examples

      iex> get_card_group!(123)
      %CardGroup{}

      iex> get_card_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card_group!(id), do: Repo.get!(CardGroup, id) |> Repo.preload(:card_sets)

  @doc """
  Creates a card_group.

  ## Examples

      iex> create_card_group(%{field: value})
      {:ok, %CardGroup{}}

      iex> create_card_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card_group(attrs \\ %{}) do
    %CardGroup{}
    |> CardGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card_group.

  ## Examples

      iex> update_card_group(card_group, %{field: new_value})
      {:ok, %CardGroup{}}

      iex> update_card_group(card_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card_group(%CardGroup{} = card_group, attrs) do
    card_group
    |> CardGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card_group.

  ## Examples

      iex> delete_card_group(card_group)
      {:ok, %CardGroup{}}

      iex> delete_card_group(card_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card_group(%CardGroup{} = card_group) do
    Repo.delete(card_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card_group changes.

  ## Examples

      iex> change_card_group(card_group)
      %Ecto.Changeset{source: %CardGroup{}}

  """
  def change_card_group(%CardGroup{} = card_group) do
    CardGroup.changeset(card_group, %{})
  end

  alias MdFlashcards.Flashcards.CardSet

  @doc """
  Returns the list of card_sets.

  ## Examples

      iex> list_card_sets()
      [%CardSet{}, ...]

  """
  def list_card_sets do
    Repo.all(CardSet)
  end

  @doc """
  Gets a single card_set.

  Raises `Ecto.NoResultsError` if the Card set does not exist.

  ## Examples

      iex> get_card_set!(123)
      %CardSet{}

      iex> get_card_set!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card_set!(id), do: Repo.get!(CardSet, id) |> Repo.preload(:cards)

  @doc """
  Creates a card_set.

  ## Examples

      iex> create_card_set(%{field: value})
      {:ok, %CardSet{}}

      iex> create_card_set(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card_set(attrs \\ %{}) do
    %CardSet{}
    |> CardSet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card_set.

  ## Examples

      iex> update_card_set(card_set, %{field: new_value})
      {:ok, %CardSet{}}

      iex> update_card_set(card_set, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card_set(%CardSet{} = card_set, attrs) do
    card_set
    |> CardSet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card_set.

  ## Examples

      iex> delete_card_set(card_set)
      {:ok, %CardSet{}}

      iex> delete_card_set(card_set)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card_set(%CardSet{} = card_set) do
    Repo.delete(card_set)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card_set changes.

  ## Examples

      iex> change_card_set(card_set)
      %Ecto.Changeset{source: %CardSet{}}

  """
  def change_card_set(%CardSet{} = card_set) do
    CardSet.changeset(card_set, %{})
  end

  alias MdFlashcards.Flashcards.Card

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards(card_set_id) do
    query = from c in Card, where: c.card_set_id == ^card_set_id
    Repo.all(query)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{source: %Card{}}

  """
  def change_card(%Card{} = card) do
    Card.changeset(card, %{})
  end
end
