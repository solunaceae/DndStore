defmodule Dndstore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DndstoreWeb.Telemetry,
      # Start the Ecto repository
      Dndstore.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dndstore.PubSub},
      # Start Finch
      {Finch, name: Dndstore.Finch},
      # Start the Endpoint (http/https)
      DndstoreWeb.Endpoint
      # Start a worker by calling: Dndstore.Worker.start_link(arg)
      # {Dndstore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dndstore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DndstoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
