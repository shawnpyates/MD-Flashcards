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
      resources "/cards", CardController, except: [:new, :edit, :update]
      put "/cards", CardController, :update
    end
  end
end
