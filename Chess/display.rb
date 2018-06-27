require "colorize"
require_relative "cursor"
require_relative "board"
require 'byebug'

SIZE = 8

class Display

  attr_reader :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    print "   "
    ("A".."H").each { |i| print " #{i} " }
    (0...SIZE).each do |row|
      # puts "\n------------------------------------"
      print "\n #{row} "
      (0...SIZE).each do |col|
        pos = [row, col]
        # if board[pos].is_a?(NullPiece)
        #   current_item = " "
        # else
        #   current_item = "♕"
        # end
        if @cursor.cursor_pos == pos
          print " #{board[pos].symbol} ".colorize(:background => :green) unless @cursor.selected
          print " #{board[pos].symbol} ".colorize(:background => :blue) if @cursor.selected
        else
          print  " #{board[pos].symbol} ".colorize(:background => :light_white) if (row + col).even?
          print  " #{board[pos].symbol} ".colorize(:background => :light_black) if (row + col).odd?
        end
        # print "|"
      end
    end
    puts
  end

  def run
    begin
      get_user_input
    rescue ArgumentError => e
      handle_error(e)
      retry
    rescue SelectError => e
      handle_error(e)
      retry
    end

  end
  def handle_error(error)
    puts error.message
    sleep(2)
  end

  def get_user_input # game.rb #play logic
    loop do
      system("clear")
      render
      @cursor.get_input
      if @cursor.selected
        if @board[@cursor.cursor_pos].is_a?(NullPiece)
          @cursor.toggle_selected
          raise SelectError.new
        end
        start_pos = @cursor.cursor_pos.dup
        while @cursor.selected
          system("clear")
          render
          @cursor.get_input
        end
        end_pos = @cursor.cursor_pos.dup
        if @board[start_pos].moves.include?(end_pos)
          if
            @board.move_piece(start_pos, end_pos)
          end
        else
          raise ArgumentError.new("Invalid move. You suck")
        end
      end
      puts "#{start_pos} #{end_pos}"
    end
  end
end

class SelectError < ArgumentError
  def message
    "Selected Invalid Position"
  end
end
