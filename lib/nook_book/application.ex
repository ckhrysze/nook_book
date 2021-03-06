defmodule NookBook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor,
       [Application.get_env(:libcluster, :topologies), [name: NookBook.ClusterSupervisor]]},

      # Start the Telemetry supervisor
      NookBookWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: NookBook.PubSub},
      # Start the Endpoint (http/https)
      NookBookWeb.Endpoint
      # Start a worker by calling: NookBook.Worker.start_link(arg)
      # {NookBook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NookBook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_phase(:init, :normal, _) do
    Application.get_env(:nook_book, :cluster_role)
    |> NookBook.Data.Setup.setup()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NookBookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
