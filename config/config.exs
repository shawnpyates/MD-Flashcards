# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :md_flashcards,
  ecto_repos: [MdFlashcards.Repo]

# Configures the endpoint
config :md_flashcards, MdFlashcardsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2vOJ3jAb3PyoXKVRjKwO67Z82Sp0GFuVEanT7oKgmvNOqQxw8pZeSZocch+KYM4A",
  render_errors: [view: MdFlashcardsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MdFlashcards.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "bjAtJnLM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user,public_repo"]},
    google: {Ueberauth.Strategy.Google, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
