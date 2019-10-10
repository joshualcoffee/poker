defmodule Poker.Hand do
  alias Poker.Card
  defstruct cards: [], suits: %{}, values: %{}

  @type t :: %__MODULE__{
          cards: List.t(Card.t())
        }
  @spec play(String.t()) :: atom()
  def play(cards) do
    cards = convert(cards)

    cond do
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

    %__MODULE__{cards: cards}
  end
end
