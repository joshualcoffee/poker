defmodule Poker.CardTest do
  use ExUnit.Case
  alias Poker.Hand

  describe "playing a hand of poker" do
    test "for high card" do
      :high_card = Hand.play("4H 6C 7H 3D QH")
    end

    test "for one pair" do
      :one_pair = Hand.play("4H 4D 6C 7H 3D")
    end

    test "for two pair" do
      :two_pair = Hand.play("4H 4D 6C 6H 3D")
    end

    test "for three of a kind" do
      :three_of_a_kind = Hand.play("4H 4D 4C 6H 3D")
    end
  end
end
