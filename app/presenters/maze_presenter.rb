class MazePresenter
  attr_accessor :board, :path

  def initialize(board)
    @board = board
  end

  def show_as_html
    output = []
    output << board.width.times.inject("+") { |str, x| str << (x == board.start_x ? "   +" : "---+")}

    # For each cell, print the right and bottom wall, if it exists.
    board.height.times do |y|
      line = board.width.times.inject("|") do |str, x|
        str << ((path && path[x][y]) ? " o " : "   ") << (board.vertical_walls[x][y] ? "|" : " ")
      end
      output << line

      output << board.width.times.inject("+") {|str, x| str << (board.horizontal_walls[x][y] ? "---+" : "   +")}
    end

    "<pre>#{output.join("\n")}</pre>".html_safe
  end

  def show_as_stdout
    puts board.width.times.inject("+") {|str, x| str << (x == @start_x ? "   +" : "---+")}


    board.height.times do |y|
      line = board.width.times.inject("|") do |str, x|
        str << (@path[x][y] ? " * " : "   ") << (board.vertical_walls[x][y] ? "|" : " ")
      end
      puts line

      puts board.width.times.inject("+") {|str, x| str << (board.horizontal_walls[x][y] ? "---+" : "   +")}
    end
  end
end
