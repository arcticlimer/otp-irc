defmodule Client.CommandTest do
  use ExUnit.Case, async: true

  alias Client.Command

  test "join" do
    assert Command.parse("join party") == {:ok, :join, "party"}
    assert Command.parse("join carl's chat") == {:ok, :join, "carl's chat"}
  end

  test "help" do
    assert Command.parse("help") == {:ok, :help}
  end

  test "exit" do
    assert Command.parse("lobby") == {:ok, :return_to_lobby}
    assert Command.parse("quit") == {:ok, :quit}
  end

  test "listing" do
    assert Command.parse("channels") == {:ok, :list_channels}
    assert Command.parse("users") == {:ok, :list_users}
  end

  test "rename" do
    assert Command.parse("rename newName") == {:ok, :update_nickname, "newName"}
  end

  test "create" do
    assert Command.parse("create elixir") == {:ok, :create_room, "elixir"}
  end

  test "unknown command" do
    assert Command.parse("you're so boring...") == {:error, :unknown_command}
    assert Command.parse("请不要打破") == {:error, :unknown_command}
  end
end
