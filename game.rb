# frozen_string_literal: true

require './player'
require './number_generator'

class Game
  include NumberGenerator

  def initialize
    @player1 = Player.new('Player_1')
    @player2 = Player.new('Player_2')
    @current_player = @player1
    @turn = 0
  end

  def start
    while @player1.score.positive? && @player2.score.positive?
      puts @turn.positive? ? '----- NEW TURN -----' : "---- LET'S BEGIN -----"
      sleep(1)
      prompt_player
      sleep(1)
      show_current_score
      switch_players
      sleep(1)
    end
    announce_winner
  end

  def prompt_player
    num1, num2 = generate_two_numbers
    puts "Question for #{@current_player.name}:"
    puts "What does #{num1} plus #{num2} equal?"
    print '> '
    answer = gets.chomp.to_i
    sleep(1)
    check_answer(num1, num2, answer)
  end

  def check_answer(num1, num2, answer)
    if num1 + num2 == answer
      puts "Yes, #{@current_player.name}! You are correct!"
    else
      puts "Seriously, #{@current_player.name}? No!"
      @current_player.decrement_score
    end
  end

  def show_current_score
    puts "P1: #{@player1.score}/3 vs P2: #{@player2.score}/3"
    @turn += 1
  end

  def switch_players
    @current_player = @current_player.name == 'Player_1' ? @player2 : @player1
  end

  def announce_winner
    puts "#{@current_player.name} wins with a score of #{@current_player.score}/3"
    play_again?
  end

  def play_again?
    loop do
      print "\nPlay again? y/n: "
      answer = gets.chomp.downcase
      exit if answer == 'n'
      if answer == 'y'
        sleep(1)
        start
      end
    end
  end
end
