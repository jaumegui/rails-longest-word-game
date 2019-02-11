require "json"
require "rest-client"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do |letter|
      letter = ('a'..'z').to_a.shuffle.sample
      @letters << letter
    end
  end

  def score
    new
    letters = params[:letters].split('')
    @word = params[:word]
    @result = @word.split('') - letters
    if @result == []
      response = RestClient.get "https://wagon-dictionary.herokuapp.com/#{@word}"
      repos = JSON.parse(response)
      if repos["found"] == true
        @score = "Congratulations! #{@word} is a valid English word!"
      else
        @score = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but #{@word} can't be build"
    end
    @score
  end
end
