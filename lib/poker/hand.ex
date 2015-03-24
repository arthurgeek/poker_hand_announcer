defmodule Poker.Hand do
  def announce(hand), do: hand |> Enum.sort(&Poker.Card.sorter/2) |> _announce

  defp _announce([%{face: face}, %{face: face}, %{face: face}, %{face: face}, _]), do: {:four_of_a_kind, face}
  defp _announce([_,%{face: face} , %{face: face}, %{face: face}, %{face: face}]), do: {:four_of_a_kind, face}

  defp _announce([%{face: face1}, %{face: face1}, %{face: face1}, %{face: face2}, %{face: face2}]), do: {:full_house, [face1, face2]}
  defp _announce([%{face: face1}, %{face: face1}, %{face: face2}, %{face: face2}, %{face: face2}]), do: {:full_house, [face2, face1]}

  defp _announce(hand = [%{suit: suit}, %{suit: suit}, %{suit: suit}, %{suit: suit}, %{suit: suit}]) do
    if straight?(hand) do
      sequence = hand |> Enum.reverse |> Enum.map(fn %{face: face} -> {face, suit} end)
      {:straight_flush, sequence}
    else
      {:flush, suit}
    end
  end

  defp _announce([%{face: face}, %{face: face}, %{face: face}, _, _]), do: {:three_of_a_kind, face}
  defp _announce([_, _, %{face: face}, %{face: face}, %{face: face}]), do: {:three_of_a_kind, face}
  defp _announce([_, %{face: face}, %{face: face}, %{face: face}, _]), do: {:three_of_a_kind, face}

  defp _announce([%{face: face1}, %{face: face1}, %{face: face2}, %{face: face2}, _]), do: {:two_pairs, [face1, face2]}
  defp _announce([_, %{face: face1}, %{face: face1}, %{face: face2}, %{face: face2}]), do: {:two_pairs, [face1, face2]}
  defp _announce([%{face: face1}, %{face: face1}, _, %{face: face2}, %{face: face2}]), do: {:two_pairs, [face1, face2]}

  defp _announce([%{face: face}, %{face: face}, _, _, _]), do: {:pair, face}
  defp _announce([_, _, _, %{face: face}, %{face: face}]), do: {:pair, face}
  defp _announce([_, %{face: face}, %{face: face}, _, _]), do: {:pair, face}
  defp _announce([_, _, %{face: face}, %{face: face}, _]), do: {:pair, face}

  defp _announce(hand) do
    if straight?(hand) do
      sequence = hand |> Enum.reverse |> Enum.map(fn %{face: face} -> face end)
      {:straight, sequence}
    else
      card = hd(hand)
      {:high_card, card.face}
    end
  end

  defp straight?(hand) do
    hand
    |> each_pair
    |> Enum.all? fn [x, y] -> Poker.Card.rank_of(x) == Poker.Card.rank_of(y) + 1 end
  end

  defp each_pair(list), do: list |> each_pair([]) |> Enum.take(4)
  defp each_pair([], result), do: Enum.reverse(result)
  defp each_pair(list = [_ | tail], result) do
    each_pair(tail, [Enum.take(list, 2)| result])
  end
end
