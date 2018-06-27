require_relative 'sliding_piece'

class Piece

  include SlidingPiece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves

  end

  def symbol
    "P"
  end

end

require 'Singleton'

class NullPiece < Piece

  include Singleton

  def initialize

  end

  def symbol
    " "
  end

  def color
    :clear
  end

end
