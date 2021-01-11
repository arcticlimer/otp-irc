defmodule Client.CLI.StylesTest do
  use ExUnit.Case, async: true

  test "colored/2 accepts an IO.ANSI color function as an atom" do
    assert Client.CLI.Styles.colored("test!", :cyan) == "\e[36mtest!\e[0m"
  end

  test "colored/2 accepts a 0..255 color code" do
    assert Client.CLI.Styles.colored("test!", 42) == "\e[38;5;42mtest!\e[0m"
  end
end
