class MazeController < ApplicationController

  def index
  end

  def generate
    if board_params_invalid?
      @error_msg = t('maze.generate.errors.invalid_params')
      return
    end

    board = Maze::Generator.new(params[:board][:width].to_i, params[:board][:height].to_i).generate
    @maze_presenter = MazePresenter.new(board)
    session[:board] = params[:board]
  rescue SystemStackError => e
    @error_msg = t('maze.generate.errors.system_stack_error')
  rescue exception => e
    @error_msg = t('maze.generate.errors.exception')
  end

  def show_path
    board = Board.where(session[:board].slice(:width, :height)).last(1).last
    @maze_presenter = MazePresenter.new(board)
    @maze_presenter.path = Maze::PathFinder.new(board).solve
  end


  private

  def board_params
    params.require(:board).permit(:width, :height)
  end

  def board_params_invalid?
    params[:board].blank? || params[:board][:width].to_i == 0 || params[:board][:height].to_i == 0
  end


end
