require_relative  'rook'
require_relative  'piece'
class Board


  SIZE = 8
  attr_reader :grid

  def self.empty_grid
    fresh_board = Array.new(SIZE) {Array.new(SIZE)}
    idx = 0
    while idx < SIZE
      if idx <= 1 || idx >= 6
        fresh_board[idx] = Array.new(SIZE) { Piece.new }
      else
        fresh_board[idx] = Array.new(SIZE) { NullPiece.new }
      end
      idx += 1
    end
    fresh_board
  end

  def self.test_grid
    test_board = Array.new(SIZE) {Array.new(SIZE)}
  end

  def populate
    i = 0
    j = 0
    (0...SIZE).each do |i|
      (0...SIZE).each do |j|
        pos = [i,j]
        if i <= 1
          self[pos] = Rook.new(:black, self, pos)
        elsif i >= 6
          self[pos] = Rook.new(:white, self, pos)
        else
          self[pos] = @null
        end
      end
    end
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
    @null = NullPiece.instance
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError.new("No piece at start position") if self[start_pos].is_a?(NullPiece)
    raise ArgumentError.new("Start Position Invalid") unless valid_pos?(start_pos)
    raise ArgumentError.new("End Position Invalid") unless valid_pos?(end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = @null
  end

  def valid_pos?(pos)
    (0...SIZE).include?(pos[0]) && (0...SIZE).include?(pos[1])
  end

end
