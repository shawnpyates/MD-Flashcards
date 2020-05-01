defmodule MdFlashcardsWeb.Router do
  use MdFlashcardsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug MdFlashcardsWeb.Plugs.SetUser
  end

  scope "/api", MdFlashcardsWeb do
    pipe_through :api

    get "/current_user", UserController, :get_current

    resources "/users", UserController, only: [:create, :update, :delete] do
      get "/card_groups", CardGroupController, :list_by_user
    end

    resources "/card_groups", CardGroupController, except: [:index, :new, :edit]

    resources "/card_sets", CardSetController, except: [:new, :edit] do
      get "/cards", CardController, :get_by_card_set
      post "/cards", CardController, :bulk_create
    end

    resources "/cards", CardController, only: [:create, :update, :delete]
  end

  scope "/auth", MdFlashcardsWeb do
    pipe_through :api

    get "/signout", UserController, :signout

    get "/:provider", UserController, :request
    get "/:provider/callback", UserController, :callback
  end
end
