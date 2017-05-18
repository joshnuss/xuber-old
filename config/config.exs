# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :xuber,
  namespace: XUber,
  ecto_repos: []

# Configures the endpoint
config :xuber, XUber.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QNlpbj2HG/n4hc00mX3VZC2HIu7p2Hc+Qi2TLGPmvrDOapkPNBe+J0X3c7tundie",
  render_errors: [view: XUber.ErrorView, accepts: ~w(html json)],
  pubsub: [name: XUber.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
