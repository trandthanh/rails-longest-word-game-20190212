require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    @english_word = english_word?(@word)

    session[:score] ||= 0
    if @included && @english_word
      session[:score] += @word.length
    else
      session[:score] += 0
    end
  end

  private

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end



