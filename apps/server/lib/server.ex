defmodule Server do
  @moduledoc """
  Documentation for `Server`.
  """

  @server_options [:binary, packet: :line, active: false, reuseaddr: true]

  @doc """
  Hello world.

  ## Examples

      iex> Server.hello()
      :world

  """
  def hello do
    :world
  end

  def accept(port) do
    {:ok, socket} = :gen_tcp.listen(port, @server_options)
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    {:ok, pid} =
      Task.Supervisor.start_child(
        Server.TaskSupervisor,
        fn -> serve(client) end
      )

    :ok = :gen_tcp.controlling_process(client, pid)
  end

  defp serve(client) do
    data = read(client)
    IO.inspect(data)

    serve(client)
  end

  defp read(client) do
    {:ok, data} = :gen_tcp.recv(client, 0)
    data
  end
end
