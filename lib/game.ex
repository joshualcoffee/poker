defmodule Poker.Game do
  @moduledoc """
  Module responsible for playing a single round of poker.
  """
  alias Poker.Hand

  def play_round(set1, set2) do
    player_1_hand = Hand.play(set1)
    player_2_hand = Hand.play(set2)

    cond do
      player_1_hand.rank > player_2_hand.rank ->
        :player_1

      player_1_hand.rank < player_2_hand.rank ->
        :player_2

      true ->
        :no_winner
    end
  end
end
