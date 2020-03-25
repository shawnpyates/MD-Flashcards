defmodule MdFlashcardsWeb.Router do
  use MdFlashcardsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MdFlashcardsWeb do
    pipe_through :api

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
    get "/:provider", UserController, :request
    get "/:provider/callback", UserController, :callback
    get "/signout", UserController, :signout
  end
end
