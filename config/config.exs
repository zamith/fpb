# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :fpb, Fpb.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "nBZKIY8PVPoZhhFBI9Ssfh03AQFgpFapRAbCKakDY0TYy0yAvd4LZweN4l+HLSV6",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Fpb.PubSub,
           adapter: Phoenix.PubSub.PG2],
  http: [port: {:system, "PORT"}]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :hound, driver: "phantomjs"
