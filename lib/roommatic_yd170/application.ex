defmodule RoommaticYd170.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RoommaticYd170Web.Telemetry,
      RoommaticYd170.Repo,
      {DNSCluster, query: Application.get_env(:roommatic_yd170, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RoommaticYd170.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RoommaticYd170.Finch},
      # Start a worker by calling: RoommaticYd170.Worker.start_link(arg)
      # {RoommaticYd170.Worker, arg},
      # Start to serve requests, typically the last entry
      RoommaticYd170Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RoommaticYd170.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RoommaticYd170Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
