require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


def perform
  # Lancement du jeu
  puts '-' * 50
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts '-' * 50

  # Initialisation du jeu
  puts 'Quel est ton prénom ?'
  print '> '
  my_game = Game.new(gets.chomp)
  binding.pry

  # Le combat
  while my_game.is_still_ongoing?
    # Affichage etat
    my_game.show_players
    # Affichage nouveaux joueurs
    my_game.new_players_in_sight
    # Affichage du menu
    my_game.menu
    # Saisie de l'utilisateur
    print '> '
    my_game.menu_choice(gets.chomp)
    # Riposte des ennemis
    my_game.enemies_attack
  end

  # Fin du jeu
  my_game.end
end

perform
