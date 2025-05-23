defmodule Atividade0903.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Atividade0903Web.Telemetry,
      Atividade0903.Repo,
      {DNSCluster, query: Application.get_env(:atividade09_03, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Atividade0903.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Atividade0903.Finch},
      # Start a worker by calling: Atividade0903.Worker.start_link(arg)
      # {Atividade0903.Worker, arg},
      # Start to serve requests, typically the last entry
      Atividade0903Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Atividade0903.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Atividade0903Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
