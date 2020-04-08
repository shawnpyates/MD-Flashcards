defmodule MdFlashcards.Repo do
  use Ecto.Repo,
    otp_app: :md_flashcards,
    adapter: Ecto.Adapters.Postgres

  use Paginator
end
