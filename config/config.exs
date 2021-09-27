# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :hello, HelloWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HelloWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Hello.PubSub,
  live_view: [signing_salt: "A4Z7g0od"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :journey, Journey.Repo,
  database: "journey",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: 5432

config :journey, ecto_repos: [Journey.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
