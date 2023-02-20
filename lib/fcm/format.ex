defmodule Fcm.Format do
  alias Fcm.Structs.Traveler
  alias Fcm.Structs.Segment


  def by_groups([]), do: "empty file"
  def by_groups(%Traveler{} = data) do
    #Group by trip_to
    Enum.group_by(data.segments, &(&1.trip_to))
    |>Enum.map(fn {k, v} -> get_trip_name(k,v) end)
  end

  defp get_trip_name(k,v) do
    trip_to(k) <>
    Enum.map_join(v,&do_entry_line(&1)) <>
    line_break()
  end

  defp do_entry_line(%Segment{type: "Flight"} = d), do: "#{d.type} from #{d.from} to #{d.to} at #{d.date_from} #{d.time_from} to #{d.time_to}" <> line_break()
  defp do_entry_line(%Segment{type: "Hotel"} = d), do: "#{d.type} at #{d.from} on #{d.date_from} to #{d.date_to}" <> line_break()
  defp do_entry_line(%Segment{type: "Train"} =d), do: "#{d.type} from #{d.from} to #{d.to} at #{d.date_from} #{d.time_from} to #{d.time_to}" <> line_break()
  defp do_entry_line(%Segment{type: _ } = d), do: "no implement #{d.type}" <> line_break()

  defp trip_to(value),do: "TRIP to #{value}" <> line_break()

  defp line_break do
    "\r\n"
  end
end