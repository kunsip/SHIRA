# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :server,
  ecto_repos: [Server.Repo]

config :sendgrid,
  api_key: {:system, "SENDGRID_API_KEY"}

# Configures the endpoint
config :server, ServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OjYKMM20jZZB/rmo109n0ynbvmrmaUZaP0Lfa0nnhtOaPiu2GhOLrFrOZtIqmlL3",
  render_errors: [view: ServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Server.PubSub,
  live_view: [signing_salt: "k9w7Yt/F"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :email,
  from_email: "magiclink@sapphirepack.org",
  subject: "Your magic link"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
