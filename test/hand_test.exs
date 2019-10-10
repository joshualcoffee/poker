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
  end
end
