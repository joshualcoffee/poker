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
      flush?(hand) ->
        :flush

      straight?(hand) ->
        :straight

      three_of_a_kind?(hand) ->
        :three_of_a_kind

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
      |> Enum.sort(&(&1.value <= &2.value))

    values = cards |> Enum.group_by(& &1.value)
    suits = cards |> Enum.group_by(& &1.suit)
    %__MODULE__{values: values, cards: cards, suits: suits}
  end

  @spec pairs(__MODULE__.t()) :: List.t()
  defp pairs(hand) do
    hand.values
    |> Map.values()
    |> Enum.filter(fn val -> length(val) == 2 end)
  end

  @spec three_of_a_kind?(__MODULE__.t()) :: boolean()
  defp three_of_a_kind?(hand) do
    values = hand.values |> Map.values() |> Enum.sort(&(length(&1) <= length(&2)))
    length(values |> List.last()) == 3
  end

  @spec straight?(__MODULE__.t()) :: boolean()
  defp straight?(hand) do
    first_card = List.first(hand.cards)
    last_card = List.last(hand.cards)
    first_card.value..last_card.value |> Enum.to_list() == hand.cards |> Enum.map(& &1.value)
  end

  @spec flush?(__MODULE__.t()) :: boolean()
  defp flush?(hand) do
    suits = hand.suits |> Map.values()
    suit = List.first(suits)
    length(suits) == 1 && length(suit) == 5
  end
end
