defmodule Poker.Card do
  @moduledoc """
  Module responsible for creating a single card.
  """
  defstruct suit: nil, value: nil, type: nil

  @type t :: %__MODULE__{
          suit: String.t(),
          type: String.t() | Integer.t(),
          value: Integer.t()
        }

  @spec convert(String.t()) :: __MODULE__.t()
  def convert(card) do
    [type, suit] = card |> String.graphemes()

    value =
      cond do
        type == "T" -> 10
        type == "J" -> 11
        type == "Q" -> 12
        type == "K" -> 13
        type == "A" -> 14
        true -> String.to_integer(type)
      end

    %__MODULE__{suit: suit, type: type, value: value}
  end
end
