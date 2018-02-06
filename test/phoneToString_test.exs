defmodule PhoneToStringTest do
  use ExUnit.Case
  doctest PhoneToString

  test "Tail call optimized" do
    assert PhoneToString.call("4088338926408") |> length == 236_196
  end

  test "Body recursive call" do
    assert PhoneToString.call_slow("4088338926408") |> length == 236_196
  end
end
