require "colorize"
require_relative "cursor"
require_relative "board"

SIZE = 8

class Display

  attr_reader :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    print "   "
    (0...SIZE).each { |i| print "  #{i} " }
    (0...SIZE).each do |row|
      puts "\n------------------------------------"
      print " #{row} | "
      (0...SIZE).each do |col|
        pos = [row, col]
        if board[pos].is_a?(NullPiece)
          current_item = " "
          # print '  '
        else
          current_item = "P"
          # print ' P'
        end
        if @cursor.cursor_pos == pos
          print "#{current_item}".colorize(:background => :green) + " | "
        else
          print "#{current_item} | "
        end
      end
    end
    puts
  end

  def get_user_input
    loop do
      system("clear")
      render
      @cursor.get_input
    end
  end
end

class String
  def bg_green
    "\e[42m#{self}\e[0m"
  end
end
