defmodule Poker.Card do
  defstruct [:face, :suit]

  def sorter(left_card, right_card) do
    rank_of(left_card) > rank_of(right_card)
  end

  def rank_of(%{face: "A"}), do: 14
  def rank_of(%{face: "K"}), do: 13
  def rank_of(%{face: "Q"}), do: 12
  def rank_of(%{face: "J"}), do: 11
  def rank_of(%{face: number}) when is_integer(number) and number in 1..10, do: number
end
