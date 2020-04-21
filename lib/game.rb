require 'pry'

# Classe qui définit les méthodes d'un jeu
class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(human_player_name)
    # Lance un jeu pour un joueur humain qui doit combattre 10 bots enemis
    @human_player = HumanPlayer.new(human_player_name)
    @players_left = 10
    @enemies_in_sight = []
  end

  def kill_player(player_to_kill)
    # Mets a jour la liste des enemis
    @enemies_in_sight.delete(player_to_kill)
    @players_left -= 1
  end

  def is_still_ongoing?
    # Verifie si le jeu est toujours en cours
    @human_player.life_points.positive? && @players_left.positive?
  end

  def show_players
    # Affiche l'etat du jeu
    puts '-' * 50
    @human_player.show_state
    puts "Il reste #{@players_left} bots ennemis à combattre"
  end

  def menu
    # Affiche le menu
    puts '-' * 50
    puts 'Quelle action veux-tu effectuer ?'
    puts 'a - chercher une meilleure arme'
    puts 's - chercher à se soigner'
    puts "\n"
    puts 'attaquer un joueur en vue :' if @enemies_in_sight.size.positive?
    i = 0
    @enemies_in_sight.each do |enemy|
      if enemy.life_points.positive?
        print "#{i} - "
        enemy.show_state
        i += 1
      end
    end
  end

  def menu_choice(choice)
    # Effectue l'action de l'utilisateur
    puts '-' * 50
    if choice == 'a'
      @human_player.search_weapon
    elsif choice == 's'
      @human_player.search_health_pack
    elsif (choice.to_i < @enemies_in_sight.size && choice.match(/[0-9]/))
      index = choice.to_i
      @human_player.attacks(@enemies_in_sight[index])
      if @enemies_in_sight[index].life_points <= 0
        kill_player(@enemies_in_sight[index])
      end
    else
      puts "Erreur de saisie : Recommence !"
      menu
      print '> '
      menu_choice(gets.chomp)
    end
  end

  def enemies_attack
    # Decrit l'attaque par tous les ennemis encore en lice
    puts '-' * 50
    if @enemies_in_sight.size.positive?
      puts "Les autres joueurs t'attaquent"
      @enemies_in_sight.each do |enemy|
        enemy.attacks(@human_player) if enemy.life_points.positive?
      end
    else
      puts "Aucun joueur en vue pour t'attaquer"
    end
  end

  def end
    # Affiche le message de fin de partie
    puts '-' * 50
    puts 'La partie est finie'
    if @human_player.life_points.positive?
      puts 'BRAVO ! TU AS GAGNE !'
    else
      puts 'Loser ! Tu as perdu'
    end
  end

  def new_players_in_sight
    # Rajoute des ennemis en vue
    puts '-' * 50
    if @enemies_in_sight.size == @players_left
      puts "Tous les joueurs sont déjà en vue"
    else
      de = rand(1..6)
      if de == 1
        puts "Aucun nouveau joueur en vue"
      elsif de >= 5
        puts "Deux nouveaux adversaires en vue"
        @enemies_in_sight << Player.new("joueur#{"%04d" % rand(9999)}")
        @enemies_in_sight << Player.new("joueur#{"%04d" % rand(9999)}")
      else
        puts "Un nouvel adversaire en vue"
        @enemies_in_sight << Player.new("joueur#{"%04d" % rand(9999)}")
      end
    end
  end
end
