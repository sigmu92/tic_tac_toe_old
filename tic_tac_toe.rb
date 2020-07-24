require 'pry'
require 'pp'

class Cell
  attr_accessor :value
  def initialize(value = '')
    @value = value
  end
end

class Player
  attr_accessor :color, :name
  def initialize(color, name)
    @color = color
    @name = name
  end
end

class Board
  attr_accessor :grid
  def initialize
    @grid = default_grid
    @empty_value = '-'
  end

  def default_grid
    Array.new(3) { Array.new(3) {"#{empty_value}"} }
  end

  def display_board
    grid.each do |x|
      x.each { |y| print "#{y} " }
      puts ''
    end
  end

  def map_move(move)
    case move.to_i
    when 1
      [0, 0]
    when 2
      [0, 1]
    when 3
      [0, 2]
    when 4
      [1, 0]
    when 5
      [1, 1]
    when 6
      [1, 2]
    when 7
      [2, 0]
    when 8
      [2, 1]
    when 9
      [2, 2]
    end
  end

  def update_board(player, cell)
    x = cell[0]
    y = cell[1]
    grid[x][y] = player.color
  end

  def check_draw
    draw = true
    grid.each do |x|
      x.each do |y|
    end 
  end
end

def main()
  puts 'Welcome to Tic Tac Toe!'
  Max = Player.new('X', 'Max')
  Meg = Player.new('0', 'Meg')
  board = Board.new
  board.display_board

  while true do
    print "#{Max.name}, it's your turn! Enter your move: "
    board.update_board(Max, board.map_move(gets.chomp))
    board.display_board
    if board.check_winner
      puts "#{Max.name} won!!!"
      break
    end
    if board.check_draw
      puts "It's a draw!!"
      break
    end
    
    print "#{Meg.name}, it's your turn! Enter your move: "
    board.update_board(Meg, board.map_move(gets.chomp))
    board.display_board
  end
end