# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :nook_book, NookBookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0XO1Bs3ZjKTQnivr8Tos0exTnktx7OpIvZjDT+B4HyXPUsJ5At55FfeM1u2EAK+j",
  render_errors: [view: NookBookWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NookBook.PubSub,
  live_view: [signing_salt: "NUyDg1li"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mnesia, dir: 'mnesia/data'

config :nook_book, cluster_role: :primary, primary_node: :"n1@127.0.0.1"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
