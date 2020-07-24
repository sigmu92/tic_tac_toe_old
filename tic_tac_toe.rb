require 'pry'
require 'pp'

class Game
  attr_accessor :p1, :p2, :board

  def initialize(players, board)
    @p1 = players[0]
    @p2 = players[1]
    @board = board
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

  def update_board(player, cell)
    x = cell[0]
    y = cell[1]
    grid[x][y] = player.color
  end

  def check_winner
    if check_rows || check_columns || check_diagonal
      return true
    end
    false
  end

  def check_draw
    grid.each do |x|
      x.each do |y|
        return false if y == '-'
      end
    end
    true
  end

  private

  def check_rows
    grid.each do |x|
      return true if (x.uniq.size == 1) && (x.uniq[0] != '-')
    end
    false
  end

  def check_diagonal
    diagonal1 = [grid[0][0], grid[1][1], grid[2][2]]
    diagonal2 = [grid[0][2], grid[1][1], grid[2][0]]
    return true if (diagonal1.uniq.size == 1) && (diagonal1.uniq[0] != '-')

    return true if (diagonal2.uniq.size == 1) && (diagonal2.uniq[0] != '-')

    false
  end

  def check_columns
    for i in 0..2 do
      test_arr = []
      grid.each {|x| test_arr.push(x[i])}
      return true if (test_arr.uniq.size == 1) && (test_arr.uniq[0] != '-')
    end
    false
  end

end


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
  if board.check_winner
    puts "#{Meg.name} won!!!"
    break
  end
  if board.check_draw
    puts "It's a draw!!"
    break
  end
end
