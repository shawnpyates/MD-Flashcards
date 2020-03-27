defmodule MdFlashcardsWeb.Router do
  use MdFlashcardsWeb, :router

  # alias MdFlashcards.Accounts.User
  # alias MdFlashcards.Repo

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug MdFlashcardsWeb.Plugs.SetUser
  end

  pipeline :auth do
    plug :accepts, ["json"]
    plug :fetch_session
    plug MdFlashcardsWeb.Plugs.SetUser
  end

  scope "/api", MdFlashcardsWeb do
    pipe_through :api

    get "/current_user", UserController, :get_current

    resources "/users", UserController, except: [:new, :edit] do
      get "/card_groups", CardGroupController, :index
    end

    resources "/card_groups", CardGroupController, except: [:index, :new, :edit] do
      get "/card_sets", CardSetController, :index
    end

    resources "/card_sets", CardSetController, except: [:index, :new, :edit] do
      get "/cards", CardController, :index
    end

    resources "/cards", CardController, except: [:index, :new, :edit]
  end

  scope "/auth", MdFlashcardsWeb do
    pipe_through :auth

    get "/signout", UserController, :signout

    get "/:provider", UserController, :request
    get "/:provider/callback", UserController, :callback
  end
end
