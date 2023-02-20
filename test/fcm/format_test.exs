defmodule Fcm.FormatTest do
  use ExUnit.Case
  alias Fcm.Format

  test "group_by trip_to return list" do

    test = %Fcm.Structs.Traveler{
      based: "BIO",
      segments: [
        %Fcm.Structs.Segment{
          type: "Flight",
          from: "BIO",
          date_from: "2023-01-05",
          time_from: "20:40",
          to: "BCN",
          date_to: "2023-01-05",
          time_to: "22:10",
          trip_id: "BIO_2023-01-05",
          trip_to: "BCN"
        },
        %Fcm.Structs.Segment{
          type: "Hotel",
          from: "BCN",
          date_from: "2023-01-05",
          time_from: nil,
          to: "BCN",
          date_to: "2023-01-10",
          time_to: nil,
          trip_id: "BIO_2023-01-05",
          trip_to: "BCN"
        }
      ]
    }

    assert Format.by_groups(test) == ["TRIP to BCN\r\nFlight from BIO to BCN at 2023-01-05 20:40 to 22:10\r\nHotel at BCN on 2023-01-05 to 2023-01-10\r\n\r\n"]
  end

  test "group_by trip_to with empty traveler return default message" do
    assert Format.by_groups([]) == "empty file"
  end

end