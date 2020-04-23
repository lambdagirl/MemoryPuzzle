require_relative "board"
require_relative "player"
require_relative "computer_player"
require 'colorize'

class Game
  attr_reader :player,   :board

  def initialize(player, size = 4)
    @size = get_size
    @board = Board.new(@size)
    @previous_guess = nil
    @player = player_or_ai

  end

    #sets difficulty
    def get_size
      puts "Welcome to the Memory Puzzle Game!".colorize(:yellow)
      sleep(1)
      puts "Please set the difficulty: ".colorize(:blue) 
      puts "easy, medium, hard".colorize( :yellow)
      loop do
        difficulty = gets.chomp.downcase
        return 2 if difficulty == "easy"
        return 4 if difficulty == "medium"
        return 6 if difficulty == "hard"
        puts "Enter easy, medium or hard".colorize( :background => :blue)
      end
    end
    
    def player_or_ai
      puts "Do you want to play yourself, or see the AI play?".colorize(:blue)
      loop do
        puts "Enter 'player' or 'ai':".colorize(:yellow)
        input = gets.chomp.downcase
        return @player = Player.new(@size) if input == "player"
        return @ai = ComputerPlayer.new(@size) if input == "ai"
        puts "Incorrect input"
      end
    end

  def compare_guess(new_guess)
    if previous_guess
      if match?(previous_guess, new_guess)
        player.receive_match(previous_guess, new_guess)
      else
        puts "Try again."
        [previous_guess, new_guess].each { |pos| board.hide(pos) }
      end
      self.previous_guess = nil
      player.previous_guess = nil
    else
      self.previous_guess = new_guess
      player.previous_guess = new_guess
    end
  end

  def get_player_input
    pos = nil

    until pos && valid_pos?(pos)
      pos = player.get_user_input
    end

    pos
  end

  def make_guess(pos)
    revealed_value = board.reveal(pos)
    player.receive_revealed_card(pos, revealed_value)
    board.render

    compare_guess(pos)

    sleep(1)
    board.render
  end

  def match?(pos1, pos2)
    board[pos1] == board[pos2]
  end

  def play

    until board.won?
      board.render
      pos = get_player_input
      make_guess(pos)
    end

    puts "Congratulations!!you won!!!!".colorize(:yellow)
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
      pos.count == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  private

  attr_accessor :previous_guess





end

if $PROGRAM_NAME == __FILE__
  size = ARGV.empty? ? 4 : ARGV.shift.to_i
  game = Game.new(ComputerPlayer.new(size), size)
  puts "FLASH!!!!!"
  game.board.render
  sleep(0.5)
  game.board.hide_all

  game.play
end
