defmodule Poker.Hand do
  alias Poker.Card
  defstruct cards: [], suits: %{}, values: %{}, rank: 0, hand: nil, hand_value: 0

  @type t :: %__MODULE__{
          cards: List.t(Card.t()),
          values: map(),
          suits: map(),
          rank: Integer.t(),
          hand_value: Integer.t(),
          hand: String.t() | nil
        }
  @spec play(String.t()) :: __MODULE__.t()
  def play(cards) do
    hand = convert(cards)
    pairs = pairs(hand)
    one_pair = length(pairs) == 1
    two_pair = length(pairs) == 2
    flush = flush?(hand)
    straight = straight?(hand)

    {rank, type, hand_value} =
      cond do
        royal_flush?(straight && flush, hand) ->
          {10, :royal_flush, hand_value(hand.cards)}

        straight && flush ->
          {9, :straight_flush, hand_value(hand.cards)}

        four_of_a_kind?(hand) ->
          {8, :four_of_a_kind, hand_value(hand.cards)}

        full_house?(hand) ->
          {7, :full_house, hand_value(hand.cards)}

        flush ->
          {6, :flush, hand_value(hand.cards)}

        straight ->
          {5, :straight, hand_value(hand.cards)}

        three_of_a_kind?(hand) ->
          {4, :three_of_a_kind, hand.values |> sort_values |> List.last() |> hand_value}

        two_pair ->
          {3, :two_pair, pairs |> hand_value}

        one_pair ->
          {2, :one_pair, pairs |> hand_value}

        true ->
          {1, :high_card, (hand.cards |> List.last()).value}
      end

    %{hand | hand: type, rank: rank, hand_value: hand_value}
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

  @spec full_house?(__MODULE__.t()) :: boolean()
  defp full_house?(hand) do
    values = hand.values |> sort_values
    length(values |> List.first()) == 2 && three_of_a_kind?(hand)
  end

  @spec three_of_a_kind?(__MODULE__.t()) :: boolean()
  defp three_of_a_kind?(hand), do: n_of_kind?(hand, 3)

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

  @spec sort_values(List.t()) :: List.t()
  defp sort_values(values), do: values |> Map.values() |> Enum.sort(&(length(&1) <= length(&2)))

  @spec four_of_a_kind?(__MODULE__.t()) :: boolean()
  defp four_of_a_kind?(hand), do: n_of_kind?(hand, 4)

  @spec n_of_kind?(__MODULE__.t(), Integer.t()) :: boolean()
  defp n_of_kind?(hand, n) do
    length(hand.values |> sort_values |> List.last()) == n
  end

  @spec royal_flush?(boolean(), __MODULE__.t()) :: boolean()
  defp royal_flush?(false, _), do: false

  defp royal_flush?(true, %{cards: cards}),
    do: List.first(cards).value == 10 && List.last(cards).value == 14

  defp hand_value(cards) do
    cards
    |> List.flatten()
    |> Enum.map(& &1.value)
    |> Enum.sum()
  end
end
