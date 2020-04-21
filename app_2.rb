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

  # Initialisation du joueur
  puts 'Quel est ton prénom ?'
  print '> '
  player = HumanPlayer.new(gets.chomp)

  # Initialisation des ennemis
  ennemies = [Player.new('Josianne'), Player.new('José')]

  # Le combat
  while player.life_points > 0 && (ennemies[0].life_points > 0 || ennemies[1].life_points > 0)
    # Affichage etat HumanPlayer
    puts '-' * 50
    player.show_state
    # Affichage du menu
    puts "\n"
    puts 'Quelle action veux-tu effectuer ?'
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'
    puts "\n"
    puts 'attaquer un joueur en vue :'
    i = 0
    ennemies.each do |ennemy|
      if ennemy.life_points.positive?
        print "#{i} - "
        ennemies[i].show_state
      end
      i += 1
    end
    # Saisie de l'utilisateur
    print '> '
    action = gets.chomp
    puts '-' * 50
    if action == 'a'
      player.search_weapon
    elsif action == 's'
      player.search_health_pack
    elsif action == '0'
      player.attacks(ennemies[0])
    elsif action == '1'
      player.attacks(ennemies[1])
    end
    # Riposte des ennemis
    puts '-' * 50
    puts "Les autres joueurs t'attaquent !"
    ennemies.each do |ennemy|
      ennemy.attacks(player) if ennemy.life_points.positive?
    end
  end

  # Fin du jeu
  puts '-' * 50
  puts 'La partie est finie'
  if player.life_points.positive?
    puts 'BRAVO ! TU AS GAGNE !'
  else
    puts 'Loser ! Tu as perdu'
  end
end

perform
