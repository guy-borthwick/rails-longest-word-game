class GamesController < ApplicationController
  def new
    # display a new random grid and a form
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    # form will be submitted (with POST) to the score action.
    @word = params[:word].upcase
    @letters = params[:letters]

    if !word_in_grid?(@word, @letters)
      @result = "Sorry, but #{@word} cannot be built out of #{formatted_letters(@letters)}."
    elsif !valid_english_word?(@word)
      @result = "#{@word} is valid according to the grid, but is not a valid English word."
    else
      @result = "#{@word} is valid according to the grid and is an English word."
    end
  end

  private

  def word_in_grid?(word, grid)
    word.chars.all? { |char| word.count(char) <= grid.count(char) }
  end

  def formatted_letters(letters)
    letters.join(', ')
  end

  require 'net/http'
  require 'json'

  def valid_english_word?(word)
    uri = URI("https://wagon-dictionary.herokuapp.com/#{word}")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
    parsed_response['found']
  end
end
