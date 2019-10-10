defmodule Poker.Game do
  @moduledoc """
  Module responsible for playing a single round of poker.
  """
  alias Poker.Hand
  alias Poker.Card
  @spec play_round(String.t(), String.t()) :: atom()
  def play_round(set1, set2) do
    player_1_hand = Hand.play(set1)
    player_2_hand = Hand.play(set2)

    cond do
      player_1_hand.rank > player_2_hand.rank ->
        :player_1

      player_1_hand.rank < player_2_hand.rank ->
        :player_2

      true ->
        tie_breaker(player_1_hand, player_2_hand)
    end
  end

  defp tie_breaker(%{hand_value: p1_hand_value, cards: p1_cards}, %{
         hand_value: p2_hand_value,
         cards: p2_cards
       })
       when p1_hand_value == p2_hand_value do
    high_card_tie_breaker(p1_cards, p2_cards)
  end

  defp tie_breaker(%{hand_value: p1_hand_value}, %{
         hand_value: p2_hand_value
       }) do
    if p1_hand_value > p2_hand_value do
      :player_1
    else
      :player_2
    end
  end

  defp high_card_tie_breaker([p1_card | p1_cards], [p2_card | p2_cards]) do
    cond do
      p1_card.value > p2_card.value ->
        :player_1

      p1_card.value < p2_card.value ->
        :player_2

      true ->
        high_card_tie_breaker(p1_cards, p2_cards)
    end
  end

  defp high_card_tie_breaker([], []), do: :no_winner
end
