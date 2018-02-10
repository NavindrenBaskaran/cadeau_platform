# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cadeau_platform,
  ecto_repos: [CadeauPlatform.Repo]

# Configures the endpoint
config :cadeau_platform, CadeauPlatformWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0cM/YDdVq6Su9J4MQFs4/1ACnRDTo8TcApfbT0vAoWpr6YSOPliuhGc7tgYUmlYl",
  render_errors: [view: CadeauPlatformWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CadeauPlatform.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :money,
  default_currency: :MYR,
  separator: ".",
  delimeter: ",",
  symbol: false,
  symbol_on_right: false,
  symbol_space: false


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
