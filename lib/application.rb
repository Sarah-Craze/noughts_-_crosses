require_relative 'board'
require_relative 'board_case'
require_relative 'game'
require_relative 'player'
require_relative 'show'
require 'colorize'
require 'bundler'
Bundler.require

class Application
    def perform
      game = Game.new
  
      while game.status == "on going"
        game.turn
      end
  
      game.game_end
  
      puts "Do you want to play again? (y/n)".colorize(:red)
      choice = gets.chomp.downcase
  
      if choice == "y"
        game.new_round
        perform
      else
        puts "Okay. See you next Time! 😊".colorize(:red)
      end
    end
  end
  
  Application.new.perform