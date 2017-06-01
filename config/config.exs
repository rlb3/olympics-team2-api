# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: API,
  ecto_repos: [API.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :api, API.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2VVnp+Z7OHanhQ2sR3vXJ0KlBdmmM7jBVh4uys6jOH3CpDUjf8+PW+VBtPM9rQqM",
  render_errors: [view: API.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: API.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
