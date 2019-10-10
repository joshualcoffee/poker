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

  # describe "tieing :high_card Poker.Game.play_round" do
  #   test "when players tie and player 1 has the higer card" do
  #     assert_winner(:player_1, Game.play_round("4H 6C 9H TD KH", "4H 6C 7H 8D QH"))
  #   end

  #   test "when players tie and player 2 has the higer card" do
  #     assert_winner(:player_2, Game.play_round("4H 6C 9H TD KH", "4H 6C 7H 8D AH"))
  #   end
  # end

  # describe "tieing :one_pair Poker.Game.play_round" do
  #   test "when players tie and player 1 has the higer pair" do
  #     assert_winner(:player_1, Game.play_round("9H 6C 9H TD KH", "4H 4C 7H 8D QH"))
  #   end

  #   test "when players tie and player 2 has the higer pair" do
  #     assert_winner(:player_2, Game.play_round("9H 6C 9H TD KH", "TH TC 7H 8D QH"))
  #   end

  #   test "when players tie and cards match" do
  #     assert_winner(:player_2, Game.play_round("9H 6C 9H TD 8H", "9H 9C 7H 8D QH"))
  #   end
  # end

  # describe "tieing :two_pair Poker.Game.play_round" do
  #   test "when players tie and player 1 has the higer pair set" do
  #     assert_winner(:player_1, Game.play_round("9H 6C 9H 6D KH", "4H 4C 7H 7D QH"))
  #   end

  #   test "when players tie and player 2 has the higer pair set" do
  #     assert_winner(:player_2, Game.play_round("3H 6C 3H 6D KH", "4H 4C 7H 7D QH"))
  #   end

  #   test "when players tie and cards match" do
  #     assert_winner(:player_2, Game.play_round("9H 6C 9H 6D 8H", "9H 9C 6H 6D QH"))
  #   end
  # end
end
