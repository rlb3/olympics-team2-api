defmodule API.Application do
  use Application

  @moduledoc false

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(API.Repo, []),
      # Start the endpoint when the application starts
      supervisor(API.Web.Endpoint, []),
      # Start your own worker by calling: API.Worker.start_link(arg1, arg2, arg3)
      # worker(API.Worker, [arg1, arg2, arg3]),
      worker(API.Cache, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: API.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
