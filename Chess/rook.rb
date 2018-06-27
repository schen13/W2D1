require_relative 'sliding_piece'

class Rook < Piece

  include SlidingPiece

  attr_reader :symbol

  def initialize(color, board, pos)
    super
  end

  def symbol
    if @color == :black
      "♜"
    else
      "♖"
    end
  end

  def move_dirs
    horizontal_dirs
  end
end
