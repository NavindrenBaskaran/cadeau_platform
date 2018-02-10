use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cadeau_platform, CadeauPlatformWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cadeau_platform, CadeauPlatform.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cadeau_platform_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
