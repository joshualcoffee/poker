defmodule Poker.Hand do
  defstruct cards: [], suits: %{}, values: %{}

  @type t :: %__MODULE__{
          cards: List.t(Card.t())
        }

  def play(cards) do
  end
end
