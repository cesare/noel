# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :noel,
  ecto_repos: [Noel.Repo]

# Configures the endpoint
config :noel, Noel.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "R7UeJo3dB4rbEF96JRnJbtApp1sbv9Ng7tqyxvKYDSBjehVH7Od0+trmDfNWElBC",
  render_errors: [view: Noel.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Noel.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
