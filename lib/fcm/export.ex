defmodule Fcm.Export do

  def console(multiline_text) when is_list(multiline_text) do
    IO.puts Enum.join(multiline_text, "")
            |>String.trim_trailing()
  end
  def console(multiline_text), do: IO.puts multiline_text
end