# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_video_stream,
  ecto_repos: [PhoenixVideoStream.Repo]

# Configures the endpoint
config :phoenix_video_stream, PhoenixVideoStreamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lzxMevhVGYC5ZZEvgeTRVx/iATdiS3rhMkTD6akLgYUcUx83lDww97z9HKryiYTv",
  render_errors: [view: PhoenixVideoStreamWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhoenixVideoStream.PubSub,
  live_view: [signing_salt: "yVWQOb2/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
