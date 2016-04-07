use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fpb, Fpb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fpb, Fpb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fpb_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :exvcr, [
  filter_sensitive_data: [
    [pattern: "<PASSWORD>.+</PASSWORD>", placeholder: "PASSWORD_PLACEHOLDER"]
  ],
  filter_url_params: false,
  response_headers_blacklist: []
]
