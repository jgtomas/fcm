defmodule FcmTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Fcm


  test "File not found" do

    assert capture_io(fn ->
                        Fcm.start("test/fixtures/fcm_no_exist_in_project.txt")
                      end
                      ) == "Could not find file.txt\n"
  end

  test "Empty file" do

    assert capture_io(fn ->
             Fcm.start("test/fixtures/file_empty.txt")
           end
           ) == "empty file\n"
  end

  test "File challenge fcm" do

    msg_challenge = """
    TRIP to BCN\r
    Flight from SVQ to BCN at 2023-01-05 20:40 to 22:10\r
    Hotel at BCN on 2023-01-05 to 2023-01-10\r
    Flight from BCN to SVQ at 2023-01-10 10:30 to 11:50\r
    \r
    TRIP to MAD\r
    Train from SVQ to MAD at 2023-02-15 09:30 to 11:00\r
    Hotel at MAD on 2023-02-15 to 2023-02-17\r
    Train from MAD to SVQ at 2023-02-17 17:00 to 19:30\r
    \r
    TRIP to NYC\r
    Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10\r
    Flight from BCN to NYC at 2023-03-02 15:00 to 22:45
    """

    assert capture_io(fn ->
             Fcm.start("test/fixtures/file_1.txt")
           end
           ) == msg_challenge
  end

  test "File segment with no connection" do

    msg = """
    TRIP to BCN\r
    Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10\r
    \r
    TRIP to BIO\r
    Hotel at BIO on 2023-01-05 to 2023-01-10
    """

    assert capture_io(fn ->
             Fcm.start("test/fixtures/file_2.txt")
           end
           ) == msg
  end

  test "Connection travel with multiples transports" do

    msg="""
    TRIP to BOS\r
    Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10\r
    Flight from BCN to NYC at 2023-03-02 15:00 to 22:45\r
    Train from NYC to BOS at 2023-03-03 09:30 to 17:00
    """

    assert capture_io(fn ->
             Fcm.start("test/fixtures/file_multiples_transports.txt")
           end
           ) == msg
  end

  test "No implementation for taxi tag" do

    msg="""
    TRIP to BCN\r
    Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10\r
    \r
    TRIP to TaxiBIO2023-01-05->2023-01-10\r
    no implement Taxi
    """

    assert capture_io(fn ->
             Fcm.start("test/fixtures/file_taxi.txt")
           end
           ) == msg
  end
end
