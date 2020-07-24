require 'pry'
require 'pp'

class Game
  attr_accessor :board

  def initialize(board)
    @board = board
  end


  def turn(player)
    pick = take_input(player)
    until validate_input(pick)
      board.display_board
      pick = take_input(player)
    end
    board.update_board(player,board.map_move(pick))
    board.display_board
  end

  
  def take_input(player)
    print "#{player.name}, it's your turn! Enter your move: "
    input = gets.chomp.to_i
  end

  def evaluate?(player)
    if board.check_winner?
      puts "#{player.name} won!!!"
      return true
    elsif board.check_draw?
      puts "It's a draw!"
      return true      
    else
      false
    end
  end

  private

  def validate_input(input)
    if ![1, 2, 3, 4, 5, 6, 7, 8, 9].include?(input) || !board.valid_move?(input)
      puts ''
      puts '***Invalid entry, try again!***'
      puts ''
      return false
    end
    return true
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
  end

  def default_grid
    empty_value = '-'
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
  
  def valid_move?(input)
    cell = map_move(input)
    x = cell[0]
    y = cell[1]
    return true if grid[x][y] == '-'
    false
  end

  def update_board(player, cell)
    x = cell[0]
    y = cell[1]
    grid[x][y] = player.color
    
  end

  def check_winner?
    if check_rows? || check_columns? || check_diagonal?
      return true
    end
    false
  end

  def check_draw?
    grid.each do |x|
      x.each do |y|
        return false if y == '-'
      end
    end
    true
  end

  private

  def check_rows?
    grid.each do |x|
      return true if (x.uniq.size == 1) && (x.uniq[0] != '-')
    end
    false
  end

  def check_diagonal?
    diagonal1 = [grid[0][0], grid[1][1], grid[2][2]]
    diagonal2 = [grid[0][2], grid[1][1], grid[2][0]]
    return true if (diagonal1.uniq.size == 1) && (diagonal1.uniq[0] != '-')

    return true if (diagonal2.uniq.size == 1) && (diagonal2.uniq[0] != '-')

    false
  end

  def check_columns?
    for i in 0..2 do
      test_arr = []
      grid.each {|x| test_arr.push(x[i])}
      return true if (test_arr.uniq.size == 1) && (test_arr.uniq[0] != '-')
    end
    false
  end

end


puts 'Welcome to Tic Tac Toe!'
puts "Enter the name of player 1: "
p1 = Player.new('X', gets.chomp)
puts "Enter the name of player 2: "
p2 = Player.new('0', gets.chomp)
board = Board.new
game = Game.new(board)
while true do
  game.turn(p1)
  if game.evaluate?(p1)
    break
  end
  game.turn(p2)
  if game.evaluate?(p2)
    break
  end
end
