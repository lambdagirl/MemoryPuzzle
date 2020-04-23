
class Player
  attr_accessor :previous_guess
  def initialize(_size)
    @previous_guess = nil
  end

  def get_user_input
    prompt
    parse(STDIN.gets.chomp)
  end

  def prompt 
    puts "Please enter the position of the card you'd like to flip (e.g., '1,3')"
      print "> "
  end

  def parse(string)
    string.split(",").map { |x| Integer(x) }
  end

  def receive_revealed_card(pos,val)
  end
  
  def receive_match(_pos1, _pos2)
    puts "It's a match!!"
  end

end
