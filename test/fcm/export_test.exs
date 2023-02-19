defmodule ExportTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias Fcm.Export

  test "String input" do

    msg="text lorem ipsu    "
    msg_final = "text lorem ipsu    \n"
    assert capture_io(fn ->
             Export.console(msg)
           end
           ) == msg_final
  end

  test "list output" do

    msg=["text lorem ipsu    "]
    msg_final = "text lorem ipsu\n"
    assert capture_io(fn ->
             Export.console(msg)
           end
           ) == msg_final
  end
end