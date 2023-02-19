defmodule Fcm.Structs.Segment do
  alias __MODULE__
  defstruct [:type, :from, :date_from, :time_from, :to, :date_to, :time_to, :trip_id, :trip_to]


  def is_transport(%Segment{type: "Flight"}), do: true
  def is_transport(%Segment{type: "Train"}), do: true
  def is_transport(%Segment{type: _ }), do: false

  def is_connection_travel(segment, next_segment) do
    {:ok, date_from} = Date.from_iso8601(segment.date_from)
    {:ok, date_to} =Date.from_iso8601(next_segment.date_to)
    Date.diff(date_from, date_to)<=1 and is_transport(segment) and is_transport(next_segment)
  end

  #["Flight", "SVQ", "2023-03-02", "06:40", "->", "BCN", "09:10"]
end