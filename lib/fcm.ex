defmodule Fcm do
  alias Fcm.Export
  alias Fcm.Format
  alias Fcm.FileInput
  alias Fcm.TravelerBuilder

  @spec start(String.t()) :: String.t()
  def start(file_path) do
    case FileInput.transform(file_path) do
      {:ok, list_based_segment} ->

        TravelerBuilder.build_detail_traveler(list_based_segment)
        |>Format.by_groups()
        |>Export.console()

      {:error, msg} ->
        IO.puts msg
    end
  end
end
