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

  defp tie_breaker(%{hand: :high_card, cards: player_1_cards}, %{
         cards: player_2_cards
       }) do
    if (player_1_cards |> List.last()).value > (player_2_cards |> List.last()).value do
      :player_1
    else
      :player_2
    end
  end

  defp tie_breaker(%{hand: hand} = player_1_hand, player_2_hand)
       when hand in [:one_pair] do
    if player_1_hand
       |> pair_sum > player_2_hand |> pair_sum do
      :player_1
    else
      :player_2
    end
  end

  @spec pair_sum(Hand.t()) :: Integer.t()
  defp pair_sum(hand) do
    hand.values
    |> Map.values()
    |> Enum.filter(fn val -> length(val) == 2 end)
    |> List.flatten()
    |> Enum.map(& &1.value)
    |> Enum.sum()
  end
end
