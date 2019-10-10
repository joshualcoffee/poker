defmodule Poker do
  @moduledoc """
  Modules is responsible for reading a .txt file and playing through hands of poker.
  """
  alias Poker.Game

  def play_hands do
    %{player_1_wins: player_1_wins} =
      File.stream!("poker.txt")
      |> Stream.map(fn ln ->
        String.replace(ln, "\n", "")
        |> String.split(" ")
        |> Enum.chunk_every(5)
        |> Enum.map(&Enum.join(&1, " "))
      end)
      |> Task.async_stream(fn [cards_1, cards_2] ->
        Game.play_round(cards_1, cards_2)
      end)
      |> Enum.reduce(%{player_1_wins: 0, player_2_wins: 0, no_winner: 0}, fn {:ok, result}, acc ->
        player_atom = String.to_existing_atom("#{result}_wins")
        player_wins = Map.get(acc, player_atom)
        acc |> Map.put(player_atom, player_wins + 1)
      end)

    IO.puts("Player one wins: #{player_1_wins} out of 1000 times. ")
  end
end
