import Config

config :libcluster,
  topologies: [
    nook_book: [
      strategy: Cluster.Strategy.Epmd,
      config: [
        hosts: [
          :"nook_book@10.0.1.102",
          :"nook_book@10.0.1.243"
        ]
      ]
    ]
  ]

config :nook_book, cluster_role: System.get_env("CLUSTER_ROLE", "member") |> String.to_atom()

config :nook_book, NookBookWeb.Endpoint,
  server: true,
  http: [port: 4000],
  url: [host: "follow.nookbook.online"],
  secret_key_base: "P302LUMxFCBc2NvN15qXnupU8vqrvGzWMFDRjlvpxpTGwTlcx0d00i8kgJHkLAWM"
