require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform
  player1 = Player.new('Josianne')
  player2 = Player.new('José')

  while player1.life_points > 0 && player2.life_points > 0
    puts '-' * 50
    puts "Voici l'état de nos joueurs : "
    player1.show_state
    player2.show_state
    puts "\n"
    puts "Passons à la phase d'attaque :"
    player1.attacks(player2)
    if player2.life_points <= 0
      puts '-' * 50
      break
    else
      player2.attacks(player1)
    end
  end
end

perform
