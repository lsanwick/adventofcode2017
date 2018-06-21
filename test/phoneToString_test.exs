defmodule PhoneToStringTest do
  use ExUnit.Case
  doctest PhoneToString

  test "Tail call optimized" do
    assert PhoneToString.call("408833892640883") |> length == 2_125_764
  end

  test "Body recursive call" do
    assert PhoneToString.call_slow("408833892640883") |> length == 2_125_764
  end
end
