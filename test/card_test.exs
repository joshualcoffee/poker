defmodule Poker.CardTest do
  use ExUnit.Case
  alias Poker.Card

  test "converts the string representation of a card" do
    assert Card.convert("TH") == %Card{
             type: "T",
             suit: "H",
             value: 10
           }
  end
end
