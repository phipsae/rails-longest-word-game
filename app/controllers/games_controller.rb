class GamesController < ApplicationController
  def new
    def generate_grid(grid_size)
      # TODO: generate random grid of letters
      charset = Array('a'..'z')
      Array.new(grid_size) { charset.sample }
    end
    @letters = generate_grid(10)
  end

  def score
    raise
  end
end
