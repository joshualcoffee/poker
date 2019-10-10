defmodule Poker.Game do
  @moduledoc """
  Module responsible for playing a single round of poker.
  """
  alias Poker.Hand

  def play_round(set1, set2) do
    {Hand.play(set1), Hand.play(set2)}
  end
end
