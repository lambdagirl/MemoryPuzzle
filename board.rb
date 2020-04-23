require 'colorize'

require_relative "card"

class Board
  attr_reader :grid, :size
  def initialize(size=4)
    @size = size
    @grid = Array.new(size) { Array.new(size) }
    populate
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos,val)
    row, col = pos
    grid[row][col] = val
  end

  def populate
    values = ("A".."Z").to_a
    num_pairs= size*size/2
    values = values.shuffle.take(num_pairs) * 2
    cards = values.map { |val| Card.new(val)}
    grid.each_index do |i|
      grid[i].each_index do |j|
        self[[i,j]] = cards.pop 
      end
    end

  end

  def render
    system("clear")

    puts "  #{(0...size).to_a.join(' ')}".colorize( :background => :blue)
    
    grid.each_with_index do |row,i|
        puts "#{i} #{row.join(' ')}".colorize( :background => :red)
    end

  end

  def won?
    grid.all? do |row|
      row.all?(&:faceup?)
    end
  end


  def hide_all
    grid.each_index do |i|
      grid[i].each_index do |j|
        hide([i,j])
      end
    end
  end

  def reveal(pos)
    if self[pos].faceup?
      puts "You can't flip a card that has already been revealed."
    else
      self[pos].reveal
    end
    self[pos].value
  end

  def hide(pos)
    self[pos].hide
  end

  def revealed?(pos)
    self[pos].revealed?
  end
  

end
