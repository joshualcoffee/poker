defmodule Poker.CardTest do
  use ExUnit.Case
  alias Poker.Hand

  describe "playing a hand of poker" do
    test "for high card" do
      :high_card = Hand.play("4H 6C 7H 3D QH")
    end
  end
end
