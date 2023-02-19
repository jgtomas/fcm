defmodule FileInputTest do
  use ExUnit.Case
  alias Fcm.FileInput

  test "Transformation works fine" do

    {:ok, result } = FileInput.transform("test/fixtures/file_1.txt")

    assert is_list(result)
    assert Enum.count(result) == 9
    assert Enum.member?(result, "RESERVATION") == false
    assert Enum.member?(result, "SEGMENT: ") == false
    assert Enum.member?(result, "BASED: ") == false

  end

end