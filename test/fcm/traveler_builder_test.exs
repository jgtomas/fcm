defmodule Fcm.TravelerBuilderTest do
  use ExUnit.Case
  alias Fcm.TravelerBuilder
  alias Fcm.Structs.Traveler

  test "build traveler flight segment" do
    list_based_segment = ["BIO", "Flight BIO 2023-03-02 06:40 -> BCN 09:10"]
    traveler = TravelerBuilder.build_detail_traveler(list_based_segment)
    assert %Traveler{} = traveler
  end

  test "build traveler hotel segment" do
    list_based_segment = ["BIO", "Hotel BCN 2023-01-05 -> 2023-01-10"]
    traveler = TravelerBuilder.build_detail_traveler(list_based_segment)
    assert %Traveler{} = traveler
  end
end