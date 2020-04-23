class ComputerPlayer
  attr_accessor :previous_guess, :size

  def initialize(size)
    @size = size
    @matched_cards = {}
    @known_cards = {}
    @previous_guess = nil
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(pos1, pos2)
    @matched_cards[pos1] = true
    @matched_cards[pos2] = true
  end

  def get_user_input
    if previous_guess
      second_guess
    else
      first_guess
    end
  end

  def unmatched_pos
    (pos, _) = @known_cards.find do |pos, val|
      @known_cards.any? do |pos2, val2|
        (pos != pos2 && val == val2) &&
          !(@matched_cards[pos] || @matched_cards[pos2])
      end
    end

    pos
  end

  def match_previous
    (pos, _) = @known_cards.find do |pos, val|
      pos != previous_guess && val == @known_cards[previous_guess] &&
        !@matched_cards[pos]
    end

    pos
  end

# On its first guess, if it knows where 2 matching cards are, guess one of them, 
#otherwise guess randomly among cards it has not yet seen.
  def first_guess
    unmatched_pos || random_guess
  end

# On its second guess, if its first guess revealed a card whose value matches a known location, 
#guess that location, otherwise guess randomly among cards it has not yet seen.
  def second_guess
    match_previous || random_guess
  end

  def random_guess
    guess = nil 
    until guess && !@known_cards[guess]
      guess= [rand(size),rand(size)]
    end
    guess
  end
end
