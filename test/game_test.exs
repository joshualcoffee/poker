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
    test "when players tie and player 1 has the higher card" do
      assert_winner(:player_1, Game.play_round("4H 6C 9H TD KH", "4H 6C 7H 8D KH"))
    end

    test "when players tie and player 2 has the higher card" do
      assert_winner(:player_2, Game.play_round("4H 6C 9H TD KH", "4H 6C 7H 8D AH"))
    end
  end

  describe "tieing :one_pair Poker.Game.play_round" do
    test "when players tie and player 1 has the higher pair" do
      assert_winner(:player_1, Game.play_round("9H 6C 9H TD KH", "4H 4C 7H 8D QH"))
    end

    test "when players tie and player 2 has the higher pair" do
      assert_winner(:player_2, Game.play_round("9H 6C 9H TD KH", "TH TC 7H 8D QH"))
    end

    test "when players tie and cards match" do
      assert_winner(:player_2, Game.play_round("9H 6C 9H TD 8H", "9H 9C 7H 8D QH"))
    end
  end

  describe "tieing :two_pair Poker.Game.play_round" do
    test "when players tie and player 1 has the higher pair set" do
      assert_winner(:player_1, Game.play_round("9H 6C 9H 6D KH", "4H 4C 7H 7D QH"))
    end

    test "when players tie and player 2 has the higher pair set" do
      assert_winner(:player_2, Game.play_round("3H 6C 3H 6D KH", "4H 4C 7H 7D QH"))
    end

    test "when players tie and cards match" do
      assert_winner(:player_2, Game.play_round("9H 6C 9H 6D 8H", "9H 9C 6H 6D QH"))
    end
  end

  describe "tieing :three_of_a_kind Poker.Game.play_round" do
    test "when players tie and player 1 has the higher three of a kind set" do
      assert_winner(:player_1, Game.play_round("9H 9C 9H 6D KH", "4H 4C 4H 7D QH"))
    end

    test "when players tie and player 2 has the higher three of a kind set" do
      assert_winner(:player_2, Game.play_round("3H 3C 3H 6D KH", "4H 4C 4H 7D QH"))
    end

    test "when players tie and cards match" do
      assert_winner(:player_2, Game.play_round("9H 9C 9H 6D 8H", "9H 9C 9H 6D QH"))
    end
  end

  describe "tieing :straight Poker.Game.play_round" do
    test "when players tie and player 1 has the higher straight" do
      assert_winner(:player_1, Game.play_round("3H 4D 5S 6C 7S", "2H 3D 4S 5C 6S"))
    end

    test "when players tie and player 2 has the higher straight" do
      assert_winner(:player_2, Game.play_round("2H 3D 4S 5C 6S", "3H 4D 5S 6C 7S"))
    end

    test "when players tie" do
      assert_winner(:no_winner, Game.play_round("2H 3D 4S 5C 6S", "2H 3D 4S 5C 6S"))
    end
  end

  describe "tieing :flush Poker.Game.play_round" do
    test "when players tie and player 1 has the higher flush" do
      assert_winner(:player_1, Game.play_round("3H 4H 5H TH KH", "2D 3D 5D 9D 8D"))
    end

    test "when players tie and player 2 has the higher flush" do
      assert_winner(:player_2, Game.play_round("2D 3D 5D 9D 8D", "3H 4H 5H TH KH"))
    end

    test "when players tie" do
      assert_winner(:no_winner, Game.play_round("2D 3D 5D 9D 8D", "2H 3H 5H 9H 8H"))
    end
  end

  describe "tieing :full_house Poker.Game.play_round" do
    test "when players tie and player 1 has the higher full house" do
      assert_winner(:player_1, Game.play_round("3H 3D 3S TH TS", "2D 2C 2S TD TC"))
    end

    test "when players tie and player 2 has the highter full house" do
      assert_winner(:player_2, Game.play_round("2D 2C 2S TD TC", "3H 3D 3S TH TS"))
    end
  end

  describe "tieing :four_of_a_kind Poker.Game.play_round" do
    test "when players tie and player 1 has the higher four of a kind" do
      assert_winner(:player_1, Game.play_round("3C 3D 3S 3H TS", "2D 2C 2S 2H TC"))
    end

    test "when players tie and player 2 has the higher four of a kind" do
      assert_winner(:player_2, Game.play_round("2D 2C 2S 2H TC", "3C 3D 3S 3H TS"))
    end
  end

  describe "tieing :straight_flush Poker.Game.play_round" do
    test "when players tie and player 1 has the higher straight flush" do
      assert_winner(:player_1, Game.play_round("4H 5H 6H 7H 8H", "2C 3C 4C 5C 6C"))
    end

    test "when players tie and player 2 has the higher straight flush" do
      assert_winner(:player_2, Game.play_round("2C 3C 4C 5C 6C", "4H 5H 6H 7H 8H"))
    end
  end
end
