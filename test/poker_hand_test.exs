defmodule PokerHandTest do
  use ShouldI
  use ExUnit.Case

  with "biggest hand being a high card" do
    should "announce a `:high_card` with the card face" do
      hand = [
        %Poker.Card{face:  7,  suit: "Diamonds"},
        %Poker.Card{face: "Q", suit: "Hearts"},
        %Poker.Card{face:  9,  suit: "Clubs"},
        %Poker.Card{face:  2,  suit: "Spades"},
        %Poker.Card{face:  5,  suit: "Hearts"},
      ]
      assert Poker.Hand.announce(hand) == {:high_card, "Q"}
    end
  end

  with "biggest hand being only one pair" do
    with "pair being the highest cards" do
      should "announce a `:pair` with the pair face" do
        hand = [
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  7,  suit: "Diamonds"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  5,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Clubs"},
        ]

        assert Poker.Hand.announce(hand) == {:pair, "Q"}
      end
    end

    with "pair being the lowest cards" do
      should "announce a `:pair` with the pair face" do
        hand = [
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  7,  suit: "Diamonds"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  9,  suit: "Clubs"},
        ]

        assert Poker.Hand.announce(hand) == {:pair, 2}
      end
    end

    with "pair not being the lowest nor the highest cards" do
      should "announce a `:pair` with the pair face" do
        hand = [
          %Poker.Card{face:  7,  suit: "Diamonds"},
          %Poker.Card{face:  9,  suit: "Clubs"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  7,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:pair, 7}

        hand = [
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  9,  suit: "Clubs"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  7,  suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Diamonds"},
        ]

        assert Poker.Hand.announce(hand) == {:pair, 9}
      end
    end
  end

  with "biggest hand being two pairs" do
    with "pairs being the highest cards" do
      should "announce a `:two_pairs` with both pair face" do
        hand = [
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Diamonds"},
          %Poker.Card{face: "Q", suit: "Clubs"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  9,  suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:two_pairs, ["Q", 9]}
      end
    end

    with "pairs being the lowest cards" do
      should "announce a `:two_pairs` with both pairs face" do
        hand = [
          %Poker.Card{face:  9,  suit: "Clubs"},
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Diamonds"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:two_pairs, [9, 2]}
      end
    end

    with "pairs being the lowest and highest cards" do
      should "announce a `:two_pairs` with both pairs face" do
        hand = [
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Spades"},
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Clubs"},
        ]

        assert Poker.Hand.announce(hand) == {:two_pairs, ["Q", 2]}
      end
    end
  end

  with "biggest hand being three of a kind" do
    with "trips being the highest cards" do
      should "announce a `:three_of_a_kind` with the trips face" do
        hand = [
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Diamonds"},
          %Poker.Card{face:  5,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Spades"},
        ]

        assert Poker.Hand.announce(hand) == {:three_of_a_kind, "Q"}
      end
    end

    with "trips being the lowest cards" do
      should "announce a `:three_of_a_kind` with the trips face" do
        hand = [
          %Poker.Card{face:  2,  suit: "Diamonds"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  9,  suit: "Spades"},
          %Poker.Card{face:  2,  suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:three_of_a_kind, 2}
      end
    end

    with "trips not being the lowest nor the highest cards" do
      should "announce a `:three_of_a_kind` with the trips face" do
        hand = [
          %Poker.Card{face:  9,  suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face:  9,  suit: "Diamonds"},
        ]

        assert Poker.Hand.announce(hand) == {:three_of_a_kind, 9}
      end
    end
  end

  with "biggest hand being straight" do
    should "announce a `:straight` with the cards faces" do
      hand = [
        %Poker.Card{face:  7,  suit: "Spades"},
        %Poker.Card{face: "J", suit: "Hearts"},
        %Poker.Card{face:  9,  suit: "Diamonds"},
        %Poker.Card{face:  8,  suit: "Clubs"},
        %Poker.Card{face: 10,  suit: "Spades"},
      ]

      assert Poker.Hand.announce(hand) == {:straight, [7, 8, 9, 10, "J"]}
    end
  end

  with "biggest hand being flush" do
    with "all cards not having the same face" do
      should "announce a `:flush` with the cards faces" do
        hand = [
          %Poker.Card{face:  5,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Hearts"},
          %Poker.Card{face:  7,  suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:flush, "Hearts"}
      end
    end

    with "some cards having the same face" do
      should "announce a `:flush` with the cards faces" do
        hand = [
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face:  9,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:flush, "Hearts"}
      end
    end
  end

  with "biggest hand being full house" do
    with "trips being the highest cards" do
      should "announce a `:three_of_a_kind` with the trips face" do
        hand = [
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Diamonds"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Spades"},
        ]

        assert Poker.Hand.announce(hand) == {:full_house, ["Q", 2]}
      end
    end

    with "trips being the lowest cards" do
      should "announce a `:three_of_a_kind` with the trips face" do
        hand = [
          %Poker.Card{face:  2,  suit: "Diamonds"},
          %Poker.Card{face: "Q",  suit: "Spades"},
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face:  2,  suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:full_house, [2, "Q"]}
      end
    end
  end

  with "biggest hand being four of a kind" do
    with "quads being the highest cards" do
      should "announce a `:four_of_a_kind` with the cards faces" do
        hand = [
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Spades"},
          %Poker.Card{face: "Q", suit: "Clubs"},
          %Poker.Card{face:  2,  suit: "Hearts"},
          %Poker.Card{face: "Q", suit: "Diamonds"},
        ]

        assert Poker.Hand.announce(hand) == {:four_of_a_kind, "Q"}
      end
    end

    with "quads being the lowest cards" do
      should "announce a `:four_of_a_kind` with the cards faces" do
        hand = [
          %Poker.Card{face:  2, suit: "Diamonds"},
          %Poker.Card{face: "Q", suit: "Hearts"},
          %Poker.Card{face:  2, suit: "Spades"},
          %Poker.Card{face:  2, suit: "Clubs"},
          %Poker.Card{face:  2,  suit: "Hearts"},
        ]

        assert Poker.Hand.announce(hand) == {:four_of_a_kind, 2}
      end
    end
  end

  with "biggest hand being straight flush" do
    should "announce a `:straight_flush` with the cards faces" do
      hand = [
        %Poker.Card{face:  9,  suit: "Hearts"},
        %Poker.Card{face: 10,  suit: "Hearts"},
        %Poker.Card{face:  7,  suit: "Hearts"},
        %Poker.Card{face:  8,  suit: "Hearts"},
        %Poker.Card{face: "J", suit: "Hearts"},
      ]

      assert Poker.Hand.announce(hand) == {:straight_flush, [{7, "Hearts"}, {8, "Hearts"}, {9, "Hearts"}, {10, "Hearts"}, {"J", "Hearts"}]}
    end
  end
end
