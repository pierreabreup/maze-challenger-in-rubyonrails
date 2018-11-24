module Maze
  class PathFinder #special thanks for https://rosettacode.org/wiki/Maze_solving#Ruby
    attr_accessor :board

    def initialize(board)
      @board = board
    end

    def solve
      @visited = Array.new(board.width) { Array.new(board.height) }
      @path   = Array.new(board.width) { Array.new(board.height) }

      @queue = []
      enqueue_cell([], board.start_x, board.start_y)

      path = nil
      until path || @queue.empty?
        path = solve_visit_cell
      end

      if path
        for x, y in path
          @path[x][y] = true
        end
      end

      @path
    end

    private

    def move_valid?(x, y)
      (0...board.width).cover?(x) && (0...board.height).cover?(y) && !@visited[x][y]
    end

    def solve_visit_cell
      path = @queue.shift
      x, y = path.last

      return path  if x == board.end_x && y == board.end_y

      @visited[x][y] = true

      for dx, dy in Maze::DIRECTIONS
        if dx.nonzero?
          new_x = x + dx
          if move_valid?(new_x, y) && !board.vertical_walls[ [x, new_x].min ][y]
            enqueue_cell(path, new_x, y)
          end
        else
          new_y = y + dy
          if move_valid?(x, new_y) && !board.horizontal_walls[x][ [y, new_y].min ]
            enqueue_cell(path, x, new_y)
          end
        end
      end

      nil
    end

    def enqueue_cell(path, x, y)
      @queue << path + [[x, y]]
    end

  end
end

