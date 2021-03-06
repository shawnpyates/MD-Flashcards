use Mix.Config

# Configure your database
config :md_flashcards, MdFlashcards.Repo,
  username: "shawnyates",
  password: "postgres",
  database: "md_flashcards_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :md_flashcards, MdFlashcardsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
