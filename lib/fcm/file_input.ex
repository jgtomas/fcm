defmodule Fcm.FileInput do

  @spec transform(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def transform(file_path) do
    case File.read(file_path) do
      {:ok, contents} ->
        #clean file
        {:ok, transform_to_list(contents)}

      {:error, :enoent} ->
          {:error, "Could not find file.txt"}

    end
  end

  defp transform_to_list(contents) do
    String.split(contents,"\n", trim: true)
    |>Enum.uniq() #delete blanks
    |>List.delete("RESERVATION")
    |>Enum.map(&String.replace(&1,["SEGMENT: ", "BASED: "], ""))
  end

end