module Maze
  DIRECTIONS = [ [1, 0], [-1, 0], [0, 1], [0, -1] ]

  class Generator #special thanks for https://rosettacode.org/wiki/Maze_generation#Ruby
    attr_accessor :width, :height

    def initialize(width, height)
      @width   = width
      @height  = height
    end

    def generate
      set_defaults

      generate_visit_cell(@start_x, @start_y)

      save_board
    end

    private

    def set_defaults
      @start_x = rand(width)
      @start_y = 0
      @end_x   = rand(width)
      @end_y   = height - 1

      @vertical_walls   = Array.new(width) { Array.new(height, true) }
      @horizontal_walls = Array.new(width) { Array.new(height, true) }

      @horizontal_walls[@end_x][@end_y] = false

      @visited = Array.new(@width) { Array.new(@height) }
    end

    def move_valid?(x, y)
      (0...@width).cover?(x) && (0...@height).cover?(y) && !@visited[x][y]
    end


    def generate_visit_cell(x, y)
      @visited[x][y] = true

      coordinates = Maze::DIRECTIONS.shuffle.map { |dx, dy| [x + dx, y + dy] }

      for new_x, new_y in coordinates
        next unless move_valid?(new_x, new_y)

        #puts "#{x} - #{y} - #{new_x} - #{new_y}"
        connect_cells(x, y, new_x, new_y)
        generate_visit_cell(new_x, new_y)
      end
    end

    def connect_cells(x1, y1, x2, y2)
      if x1 == x2
        @horizontal_walls[x1][ [y1, y2].min ] = false
      else
        @vertical_walls[ [x1, x2].min ][y1] = false
      end
    end

    def save_board
      Board.create(
        width: width,
        height:  height,
        start_x: @start_x,
        start_y: @start_y,
        end_x: @end_x,
        end_y: @end_y,
        vertical_walls: @vertical_walls,
        horizontal_walls: @horizontal_walls
      )
    end

  end
end
