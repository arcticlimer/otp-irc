defmodule Client.Shell do
  alias Client.CLI.Styles

  def start(opts) do
    host = String.to_charlist(opts.options.host)
    port = opts.options.port

    _name = get_name()

    _socket =
      case :gen_tcp.connect(host, port, [:binary]) do
        {:ok, socket} ->
          "Succesfully connected!"
          |> Styles.colored(:green)
          |> IO.puts()

          socket

        {:error, reason} ->
          "Connection error: #{inspect(reason)}"
          |> Styles.colored(:red)
          |> IO.puts()

          System.halt(1)
      end

    welcome(host, port)
    repl()
  end

  defp repl do
    input = IO.gets(purple("~> "))

    if String.starts_with?(input, "/") do
      input
      |> String.slice(1..-2)
      |> Client.Command.parse()
      |> IO.inspect()
    end

    repl()
  end

  defp welcome(host, port) do
    purple(
      ~S"""
      Welcome to
          ____  __________     ________  ________
          / __ \/_  __/ __ \   /  _/ __ \/ ____/ /
         / / / / / / / /_/ /   / // /_/ / /   / /
        / /_/ / / / / ____/  _/ // _, _/ /___/_/
        \____/ /_/ /_/      /___/_/ |_|\____(_)

      """ <>
        """
        Connected to: #{host}:#{port}
        Type /help for more information about commands.
        """
    )
    |> IO.puts()
  end

  defp get_name do
    purple("Please insert a nickname to start: ")
    |> IO.gets()
  end

  defp purple(text) do
    Styles.colored(text, 207)
  end
end
