defmodule MdFlashcards.AccountsTest do
  use MdFlashcards.DataCase

  alias MdFlashcards.Accounts

  describe "users" do
    alias MdFlashcards.Accounts.User

    @valid_attrs %{
      email: "some email",
      name: "some name",
      provider: "some provider",
      token: "some token"
    }
    @update_attrs %{
      email: "some updated email",
      name: "some updated name",
      provider: "some updated provider",
      token: "some updated token"
    }
    @invalid_attrs %{email: nil, name: nil, provider: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    defp drop_card_groups(record) do
      record |> Map.from_struct() |> Map.drop([:card_groups])
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture() |> drop_card_groups()
      fetched_user = Accounts.get_user!(user.id) |> drop_card_groups()
      assert fetched_user == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.provider == "some provider"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.provider == "some updated provider"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      updated_user = user |> drop_card_groups()
      fetched_user = Accounts.get_user!(user.id) |> drop_card_groups()
      assert updated_user == fetched_user
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end
end
