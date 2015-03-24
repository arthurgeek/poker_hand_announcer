defmodule PokerCardTest do
  use ExUnit.Case

  test "sorter: 'A' is bigger than 'K'" do
    assert Poker.Card.sorter(%Poker.Card{face: "A"}, %Poker.Card{face: "K"}) == true
  end

  test "sorter: 'K' is bigger than 'Q'" do
    assert Poker.Card.sorter(%Poker.Card{face: "K"}, %Poker.Card{face: "Q"}) == true
  end

  test "sorter: 'Q' is bigger than 'J'" do
    assert Poker.Card.sorter(%Poker.Card{face: "Q"}, %Poker.Card{face: "J"}) == true
  end

  test "sorter: 'J' is bigger than '10'" do
    assert Poker.Card.sorter(%Poker.Card{face: "J"}, %Poker.Card{face: 10}) == true
  end

  test "sorter: '10' is bigger than '9'" do
    assert Poker.Card.sorter(%Poker.Card{face: 10}, %Poker.Card{face: 9}) == true
  end

  test "sorter: '9' is bigger than '8'" do
    assert Poker.Card.sorter(%Poker.Card{face: 9}, %Poker.Card{face: 8}) == true
  end

  test "sorter: '8' is bigger than '7'" do
    assert Poker.Card.sorter(%Poker.Card{face: 8}, %Poker.Card{face: 7}) == true
  end

  test "sorter: '7' is bigger than '6'" do
    assert Poker.Card.sorter(%Poker.Card{face: 7}, %Poker.Card{face: 6}) == true
  end

  test "sorter: '6' is bigger than '5'" do
    assert Poker.Card.sorter(%Poker.Card{face: 6}, %Poker.Card{face: 5}) == true
  end

  test "sorter: '5' is bigger than '4'" do
    assert Poker.Card.sorter(%Poker.Card{face: 5}, %Poker.Card{face: 4}) == true
  end

  test "sorter: '4' is bigger than '3'" do
    assert Poker.Card.sorter(%Poker.Card{face: 4}, %Poker.Card{face: 3}) == true
  end

  test "sorter: '3' is bigger than '2'" do
    assert Poker.Card.sorter(%Poker.Card{face: 3}, %Poker.Card{face: 2}) == true
  end

  test "sorter: '2' is not bigger than 'A'" do
    assert Poker.Card.sorter(%Poker.Card{face: 2}, %Poker.Card{face: "A"}) == false
  end

  test "rank_of '2' is '2'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 2}) == 2
  end

  test "rank_of '3' is '3'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 3}) == 3
  end

  test "rank_of '4' is '4'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 4}) == 4
  end

  test "rank_of '5' is '5'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 5}) == 5
  end

  test "rank_of '6' is '6'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 6}) == 6
  end

  test "rank_of '7' is '7'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 7}) == 7
  end

  test "rank_of '8' is '8'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 8}) == 8
  end

  test "rank_of '9' is '9'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 9}) == 9
  end

  test "rank_of '10' is '10'" do
    assert Poker.Card.rank_of(%Poker.Card{face: 10}) == 10
  end

  test "rank_of 'J' is '11'" do
    assert Poker.Card.rank_of(%Poker.Card{face: "J"}) == 11
  end

  test "rank_of 'Q' is '12'" do
    assert Poker.Card.rank_of(%Poker.Card{face: "Q"}) == 12
  end

  test "rank_of 'K' is '13'" do
    assert Poker.Card.rank_of(%Poker.Card{face: "K"}) == 13
  end

  test "rank_of 'A' is '14'" do
    assert Poker.Card.rank_of(%Poker.Card{face: "A"}) == 14
  end
end
