use Mix.Config

# Configure your database
config :spendable, Spendable.Repo,
  password: nil,
  database: "spendable_test",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spendable, Spendable.Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :exq, queues: []

config :bcrypt_elixir, :log_rounds, 1

config :spendable, Plaid,
  base_url: "https://sandbox.plaid.com",
  client_id: "test",
  secret_key: "test",
  public_key: "test"

config :tesla, adapter: Tesla.Mock
