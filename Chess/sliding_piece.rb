require 'byebug'

module SlidingPiece

  HORIZONTAL_DIRS = [[-1, 0], [1, 0], [0, 1], [0, -1]]
  DIAGONAL_DIRS = [[-1, 1], [1, 1], [1, -1], [-1, -1]]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []
    move_dirs.each { |dx, dy| moves.concat(grow_moves_in_dir(dx, dy)) }
    moves
  end

  private

  def move_dirs

  end

  def grow_moves_in_dir(dx, dy)
    moves = []
    new_pos = [self.pos[0], self.pos[1]]
    loop do
      new_pos[0] += dx
      new_pos[1] += dy
      break unless @board.valid_pos?(new_pos)
      moves << new_pos.dup unless self.color == @board[new_pos].color
      break if @board[new_pos].is_a?(Piece) && !@board[new_pos].is_a?(NullPiece)
      # break unless self.valid_move?(new_pos)
    end
    moves
  end

end
