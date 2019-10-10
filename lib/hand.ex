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

    cond do
      two_pair?(hand) ->
        :two_pair

      one_pair?(hand) ->
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

  @spec one_pair?(__MODULE__.t()) :: boolean()
  defp one_pair?(hand) do
    hand.values
    |> Map.values()
    |> Enum.find(fn val -> length(val) == 2 end)
  end

  @spec two_pair?(__MODULE__.t()) :: boolean()
  defp two_pair?(hand) do
    hand.values
    |> Map.values()
    |> Enum.filter(fn val -> length(val) == 2 end) == 2
  end
end
