defmodule Poker.CardTest do
  use ExUnit.Case
  alias Poker.Hand

  describe "playing a hand of poker" do
    test "for high card" do
      assert :high_card = Hand.play("4H 6C 7H 3D QH")
    end

    test "for one pair" do
      assert :one_pair = Hand.play("4H 4D 6C 7H 3D")
    end

    test "for two pair" do
      assert :two_pair == Hand.play("4H 4D 6C 6H 3D")
    end

    test "for three of a kind" do
      assert :three_of_a_kind == Hand.play("4H 4D 4C 6H 3D")
    end

    test "for straight" do
      assert :straight == Hand.play("3H 4D 5C 6D 7S")
    end

    test "for false positive in straight" do
      refute Hand.play("3H 4D 8C 6D 7S") == :straight
    end
  end
end
