# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :listing_web,
  ecto_repos: [ListingWeb.Repo]

# Configures the endpoint
config :listing_web, ListingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x+50PhPdcYTv9ikgs5t30BZkvh6RYZvgcm2XGxcVmUNNbYwRWNIoObgUBhVF2Yat",
  render_errors: [view: ListingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ListingWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
