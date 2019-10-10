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
    flush = flush?(hand)
    straight = straight?(hand)

    {rank, type} =
      cond do
        royal_flush?(straight && flush, hand) ->
          {10, :royal_flush}

        straight && flush ->
          {9, :straight_flush}

        four_of_a_kind?(hand) ->
          {8, :four_of_a_kind}

        full_house?(hand) ->
          {7, :full_house}

        flush ->
          {6, :flush}

        straight ->
          {5, :straight}

        three_of_a_kind?(hand) ->
          {4, :three_of_a_kind}

        two_pair ->
          {3, :two_pair}

        one_pair ->
          {2, :one_pair}

        true ->
          {1, :high_card}
      end

    %{hand: type, cards: hand.cards, rank: rank}
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
end
