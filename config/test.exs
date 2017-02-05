use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :noel, Noel.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :noel, Noel.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("NOEL_DB_USERNAME") || "postgres",
  password: System.get_env("NOEL_DB_PASSWORD") || "",
  database: "noel_test",
  hostname: System.get_env("NOEL_DB_HOSTNAME") || "localhost",
  port:     System.get_env("NOEL_DB_PORT") || 5432,
  pool: Ecto.Adapters.SQL.Sandbox
