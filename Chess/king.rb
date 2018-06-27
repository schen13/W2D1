require_relative 'stepping_piece'

class King < Piece

  include SteppingPiece
  
  attr_reader :symbol

  def initialize(color, board, pos)
    super
  end

  def symbol
    if @color == :black
      "♚"
    else
      "♔"
    end
  end

  private
  def move_diffs

  end
end
