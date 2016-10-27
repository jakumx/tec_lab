# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tec_lab,
  ecto_repos: [TecLab.Repo]

# Configures the endpoint
config :tec_lab, TecLab.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y731zRcOFPV4/jqhMurjIvTx7c8N3tSyrr8vMu2yV+US02GXeuueg1Ldk7/bvGJt",
  render_errors: [view: TecLab.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TecLab.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true,
  migration: false,
  sample_binary_id: "111111111111111111111111"

config :exredis,
  host: "127.0.0.1",
  port: 6379,
  password: "",
  db: 0,
  reconnect: :no_reconnect,
  max_queue: :infinity

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
