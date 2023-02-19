defmodule Fcm.Structs.Traveler do
  alias Fcm.Structs.{Segment}
  defstruct [:based, :segments]

  def segments(row_segment, based_user) do
   Enum.map(row_segment, &build_segments(&1))
    |> Enum.sort_by(&{&1.date_from,&1.date_to})
    |> group_by_trip(nil, nil, nil,based_user)

  end

  def build_segments(row) do
    #get all attributes
    list_attr_row = String.split(row, " ")

    #get type trip
    type= List.first(list_attr_row)

    type_segment(list_attr_row, type)
  end

  defp type_segment(list, type) when type == "Hotel" do
    %Segment{
      type: Enum.at(list, 0),
      from: Enum.at(list, 1),
      date_from: Enum.at(list, 2),
      time_from: nil,
      to: Enum.at(list, 1),
      date_to: Enum.at(list, 4),
      time_to: nil
    }
  end

  defp type_segment(list, type) when type in ["Train", "Flight"] do
    #equal date, flight/train same day
    %Segment{
      type: Enum.at(list, 0),
      from: Enum.at(list, 1),
      date_from: Enum.at(list, 2),
      time_from: Enum.at(list, 3),
      to: Enum.at(list, 5),
      date_to: Enum.at(list, 2),
      time_to: Enum.at(list, 6)
    }
  end

  defp type_segment(list, _) do
    # we can discard this segment instead of displaying a message
    today = DateTime.utc_now()
            |> Calendar.strftime("%Y-%m-%d")
    %Segment{
       type: Enum.at(list, 0),
       from: Enum.map_join(list,"", fn value -> value end)                           ,
       date_from: today,
       time_from: nil,
       to: Enum.map_join(list,"", fn value -> value end),
       date_to: today,
       time_to: nil
    }
  end

  # Start
  defp group_by_trip([h | t], nil, nil, nil, based_user) do
    id_group_trip =  "#{based_user}_#{h.date_from}"
    name_group_trip = get_name_trip_to([h | t])
    [%{h | trip_id: "#{based_user}_#{h.date_from}" , trip_to: name_group_trip} | group_by_trip(t, h, id_group_trip, name_group_trip, based_user)]
  end

  # continue group
  defp group_by_trip([h | t], previous, id_trip, name_trip, based_user) when previous.to == h.from and h.from != based_user do
    [%{h | trip_id: id_trip , trip_to: name_trip}| group_by_trip(t, h, id_trip, name_trip, based_user)]
  end

  # new group
  defp group_by_trip([h | t], _, _, _, based_user) do
    id_new_group_trip =  "#{based_user}_#{h.date_from}"
    name_group_trip = get_name_trip_to([h | t])
    [%{h | trip_id: id_new_group_trip, trip_to: name_group_trip}| group_by_trip(t, h, id_new_group_trip, name_group_trip, based_user)]
  end

  # end group
  defp group_by_trip([], _, _, _, _) do
    []
  end

  defp get_name_trip_to([h | []]), do: h.to
  defp get_name_trip_to([h | [n|t]]) do
      cond do
        Segment.is_connection_travel(h,n) -> get_name_trip_to([n|t])
        !Segment.is_connection_travel(h,n) -> h.to
      end
  end


end