defmodule Poker.Hand do
  alias Poker.Card
  defstruct cards: [], suits: %{}, values: %{}

  @type t :: %__MODULE__{
          cards: List.t(Card.t()),
          values: map(),
          suits: map()
        }
  @spec play(String.t()) :: atom()
  def play(cards) do
    hand = convert(cards)
    pairs = pairs(hand)
    one_pair = length(pairs) == 1
    two_pair = length(pairs) == 2

    cond do
      two_pair ->
        :two_pair

      one_pair ->
        :one_pair

      true ->
        :high_card
    end
  end

  @spec convert(String.t()) :: __MODULE__.t()
  defp convert(cards) do
    cards =
      cards
      |> String.split(" ")
      |> Enum.map(&Card.convert(&1))

    values = cards |> Enum.group_by(& &1.value)
    %__MODULE__{values: values, cards: cards}
  end

  @spec pairs(__MODULE__.t()) :: List.t()
  defp pairs(hand) do
    hand.values
    |> Map.values()
    |> Enum.filter(fn val -> length(val) == 2 end)
  end
end
