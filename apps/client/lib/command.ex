defmodule Client.Command do
  def parse(command) do
    # TODO nice parser
    case String.split(command) do
      ["help"] -> {:ok, :help}
      ["lobby"] -> {:ok, :return_to_lobby}
      ["quit"] -> {:ok, :quit}
      ["channels"] -> {:ok, :list_channels}
      ["rename", new_nick] -> {:ok, :update_nickname, new_nick}
      ["create", room_name] -> {:ok, :create_room, room_name}
      ["users"] -> {:ok, :list_users}
      ["join", channel] -> {:ok, :join, channel}
      _ -> {:error, :unknown_command}
    end
  end
end
