defmodule Server.Application do
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Server.TaskSupervisor},
      Supervisor.child_spec(
        {Task, fn -> Server.accept(port()) end},
        restart: :permanent
      )
    ]

    opts = [strategy: :one_for_one, name: Server.Supervisor]
    Logger.info("Accepting connections on port #{port()}!")
    Supervisor.start_link(children, opts)
  end

  defp port do
    # TODO config not being loaded
    Application.get_env(:server, :port, 6667)
  end
end
