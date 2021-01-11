defmodule Client.CLI.Styles do
  @moduledoc """
  A simple wrapper for IO.ANSI
  """
  @type color ::
          0..255
          | :red
          | :black
          | :red
          | :green
          | :yellow
          | :blue
          | :magenta
          | :cyan
          | :white

  @spec colored(binary, color) :: binary
  def colored(text, color)

  def colored(text, code) when is_integer(code) do
    color = IO.ANSI.color(code)
    reset(color <> text)
  end

  def colored(text, io_ansi_color) do
    color = apply(IO.ANSI, io_ansi_color, [])
    reset(color <> text)
  end

  defp reset(text) do
    text <> IO.ANSI.reset()
  end
end
