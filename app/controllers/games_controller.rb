# require 'open-uri'
# require 'json'

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
    @word = params[:word]
    @grid = params[:tag_list]


    def word_in_grid?(attempt, grid)
      (attempt.to_s.split("") - grid.to_s.split("")).empty?
    end

    def english_word?(attempt)
      url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
      user_serialized = URI.open(url).read
      user = JSON.parse(user_serialized)
      user['found']
    end

    def run_game(word, grid) # , start_time, end_time
      # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
      # score = 0
      # time = end_time - start_time
      if word_in_grid?(word, grid) == false
        message = "Sorry but #{word.upcase} cannot build out of #{@grid}"
      elsif english_word?(word) == false
        message = "Lost, #{word.upcase} isnt an English word"
      else
        # score = score_calc(time, attempt)
        message = "Congratulations, you found #{word.upcase}"
      end
      { message: message } # score: score, , time: time
    end

    def score_calc(time, attempt)
      attempt.length * (1.0 - (time / 60.0))
    end

    @result = run_game(@word, @grid)

  end
end
