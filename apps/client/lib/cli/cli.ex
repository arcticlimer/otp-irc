defmodule Client.CLI do
  @moduledoc false

  def main(argv) do
    Optimus.new!(
      name: "client",
      description: "Client for connecting to the OTP IRC",
      version: "0.1",
      options: [
        host: [
          help: "The host server to connect",
          short: "-h",
          parser: :string,
          default: "localhost"
        ],
        port: [
          help: "The server port to connect",
          short: "-p",
          parser: :integer,
          default: 6667
        ]
      ]
    )
    |> Optimus.parse!(argv)
    |> Client.Shell.start()
  end
end
