defmodule MdFlashcards.DatabaseSeeder do
  alias MdFlashcards.Repo
  alias MdFlashcards.Accounts.User
  alias MdFlashcards.Flashcards.CardGroup
  alias MdFlashcards.Flashcards.CardSet
  alias MdFlashcards.Flashcards.Card

  def create_card(set_id) do
    Repo.insert! %Card{
      question: Faker.Lorem.sentence(10, "?"),
      answer: Faker.Lorem.sentence(10, "."),
      card_set_id: set_id
    }
  end

  def create_card_set(group_id) do
    set = group = Repo.insert! %CardSet{
      name: Faker.Lorem.sentence(2, ""),
      card_group_id: group_id
    }
    random_times = Faker.random_between(2, 30)
    (1..random_times)
      |> Enum.each(fn _ -> MdFlashcards.DatabaseSeeder.create_card(set.id) end)
  end

  def create_card_group(user_id) do
    group = Repo.insert! %CardGroup{
      name: Faker.Lorem.sentence(2, ""),
      user_id: user_id
    }
    random_times = Faker.random_between(2, 5)
    (1..random_times)
      |> Enum.each(fn _ -> MdFlashcards.DatabaseSeeder.create_card_set(group.id) end)
  end

  def create_user do
    user = Repo.insert! %User{
      name: Faker.Name.name,
      email: Faker.Internet.email,
      provider: "Github",
      token: Faker.String.base64(40)
    }
    random_times = Faker.random_between(2, 5)
    (1..random_times)
      |> Enum.each(fn _ -> MdFlashcards.DatabaseSeeder.create_card_group(user.id) end)
  end
end

(1..15) |> Enum.each(fn _ -> MdFlashcards.DatabaseSeeder.create_user() end)
