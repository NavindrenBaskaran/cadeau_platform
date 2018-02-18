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

config :ex_cldr,
  default_locale: "en",
  locales: ["fr", "en"],
  gettext: MyApp.Gettext,
  data_dir: "./priv/cldr",
  precompile_number_formats: ["¤¤#,##0.##"],
  precompile_transliterations: [{:latn, :arab}, {:thai, :latn}],
  json_library: Poison

config :ex_money,
  exchange_rates_retrieve_every: 300_000,
  api_module: Money.ExchangeRates.OpenExchangeRates,
  callback_module: Money.ExchangeRates.Callback,
  exchange_rates_cache_module: Money.ExchangeRates.Cache.Ets,
  preload_historic_rates: nil,
  retriever_options: nil,
  log_failure: :warn,
  log_info: :info,
  log_success: nil,
  json_library: Poison
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
