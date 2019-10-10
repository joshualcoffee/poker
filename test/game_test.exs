defmodule Poker.GameTest do
  use ExUnit.Case
  alias Poker.Game

  def assert_winner(player, winner) do
    assert player == winner
  end

  describe "Poker.Game.play_round" do
    test "when player 1 wins" do
      assert_winner(:player_1, Game.play_round("4H 6C TH TD QH", "4H 6C 7H 3D QH"))
    end
  end
end
