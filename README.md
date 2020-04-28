## MD Flashcards (API)

API for a web application that enables users to create flashcards that support markdown and code snippets.

Demo version [available here](https://md-flashcards-ui.herokuapp.com/) (it may take a minute to load).

React frontend using this API [can be found here](https://github.com/shawnpyates/MD-Flashcards-UI).

#### To run locally:

1. Install dependencies: `mix deps.get`

1. You will need to [run your own local Postgres database](https://github.com/Kinto/kinto/wiki/How-to-run-a-PostgreSQL-server%3F) and to fill out the database configuration in `config/dev.exs` accordingly.

1. Create and migrate your database: `mix ecto.steup`

1. You will need to run a frontend locally [using the instructions here](https://github.com/shawnpyates/MD-Flashcards-UI/blob/master/README.md).

1. This app uses OAuth for user authentication. You will need to create your own OAuth app for either [Google](https://developers.google.com/identity/protocols/oauth2) or [Github](https://developer.github.com/apps/building-oauth-apps/).

1. Create a root-level `.env` file that contains the following credentials:

    ```
      export GOOGLE_CLIENT_ID=your_google_client_id
      export GOOGLE_CLIENT_SECRET=your_google_client_secret

      export GITHUB_CLIENT_ID=your_github_client_id
      export GITHUB_CLIENT_SECRET=your_github_client_secret

      # must match exactly the URL of your local frontend
      export ALLOWED_ORIGIN_URL=your_frontend_url
    ```

1. Source your `.env` file so that the server process can read it: `source .env`

1. Start the Phoenix server: `mix phx.server`

#### To seed database locally (creates users, card groups, card sets, and cards):

`mix run priv/repo/database_seeder.exs`

#### To run tests:

`mix test`