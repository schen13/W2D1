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

  def initialize(grid = Board.empty_grid)
    @grid = grid
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
    self[start_pos] = NullPiece.new #NullPiece? shrug
  end

  def valid_pos?(pos)
    (0...SIZE).include?(pos[0]) && (0...SIZE).include?(pos[1])
  end

end
