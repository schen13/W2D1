require_relative 'sliding_piece'
require_relative 'piece'

class Rook < Piece

  include SlidingPiece

  attr_reader :symbol

  def symbol
    @color == :black ? "♜" : "♖"
  end

  private

  def move_dirs
    horizontal_dirs
  end
end
