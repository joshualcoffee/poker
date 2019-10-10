defmodule Poker.GameTest do
  use ExUnit.Case
  alias Poker.Game

  def assert_winner(player, winner) do
    assert player == winner
  end

  describe "winning Poker.Game.play_round" do
    test "when player 1 wins" do
      assert_winner(:player_1, Game.play_round("4H 6C TH TD QH", "4H 6C 7H 3D QH"))
    end

    test "when player 2 wins" do
      assert_winner(:player_2, Game.play_round("4H 6C TH TD QH", "4H 6C QH QD QH"))
    end
  end

  describe "tieing :high_card Poker.Game.play_round" do
    test "when players tie and player 1 has the higer card" do
      assert_winner(:player_1, Game.play_round("4H 6C 9H TD KH", "4H 6C 7H 8D QH"))
    end

    test "when players tie and player 2 has the higer card" do
      assert_winner(:player_2, Game.play_round("4H 6C 9H TD KH", "4H 6C 7H 8D AH"))
    end
  end
end