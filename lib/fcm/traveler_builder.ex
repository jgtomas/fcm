defmodule Fcm.TravelerBuilder do
  alias Fcm.Structs.Traveler

  def build_detail_traveler([]), do: []
  def build_detail_traveler(list_based_segment) do
    #get based
    based_user = get_based(list_based_segment)
    #delete Based line
    rows_segment = List.delete_at(list_based_segment,0)

    %Traveler{
      based: based_user,
      segments: Traveler.segments(rows_segment, based_user)
    }

  end

  defp get_based(list_based_segment) do
    List.first(list_based_segment)
    |> String.trim
  end
end