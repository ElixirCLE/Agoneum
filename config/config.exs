# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :agoneum,
  ecto_repos: [Agoneum.Repo]

# Configures the endpoint
config :agoneum, AgoneumWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "94tJaReWHmXpzPGLsX7LMi3UXD1WZwZB1L7+Zp/KL9YhspYx0NRpcjBrIJMfWi6Q",
  render_errors: [view: AgoneumWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Agoneum.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Slime
config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :guardian, Guardian,
  allowed_algos: ["ES512"],
  verify_module: Guardian.JWT,
  issuer: "Pairmotron",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: %{
    "crv" => "P-521",
    "d" => "AbAaWrwXwDYiFjJQw5ZAjHExr_0OGh-QvrDyV8MN9V8CMp4G68JxidFLCFcKKobekxARgfGm73Ezctdd_a44P2vp",
    "kty" => "EC",
    "x" => "AH2RCgSAhAOEzrstP2PR1EdtCThncwux_Q2aVJLnD31TA-tAQE2d5LaCKyhspXC0LNWMHKSN6wRP1wfKh2DlJmHJ",
    "y" => "AWAGifHC0Er1NDj4sPTu8Jhh1xmMM4LTOz8ubbq2Bd-uO_iKIDcmPFRA-b9vevn6L9brzkM2qOVyFdw2cMFeYKy8"
  },
  serializer: AgoneumWeb.GuardianSerializer

config :ueberauth, Ueberauth,
  base_path: "/login",
  providers: [
    facebook: { Ueberauth.Strategy.Facebook, [
      default_scope: "email,public_profile",
      profile_fields: "name,email"
    ]},
    google: { Ueberauth.Strategy.Google, [
      default_scope: "email profile"
    ]},
    identity: { Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"]
    ]}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: "882284788592067",
  client_secret: "4749013b002d7ed5acaad9b55797fade"

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "100732563415-5efppgqkh9nk609m8u4v97ccobbvh7j1.apps.googleusercontent.com",
  client_secret: "s1iVunv1TJ5YRMVw2umKfCzW"

config :canary,
  repo: Agoneum.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
