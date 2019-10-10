defmodule Poker.Game do
  use ExUnit.Case
  alias Poker.Game

  describe "Poker.Game.play_round" do
    test "returning player hands" do
      {:high_card, :high_card} = Game.play_round("4H 6C 7H 3D QH", "4H 6C 7H 3D QH")
    end
  end
end
