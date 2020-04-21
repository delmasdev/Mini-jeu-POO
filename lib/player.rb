require 'pry'

# Cette classe permet de definir un joueur avec un nom, des points de vie
class Player
  attr_accessor :name, :life_points

  def initialize(name)
    # Cree un player avec le nom donne en argument et 10 points de vie
    @name = name
    @life_points = 10
  end

  def show_state
    # Affiche l'etat d'un joueur
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage_received)
    # Subit une attaque avec damage_received points de dommage
    @life_points -= damage_received
    puts "le joueur #{@name} a été tué !" if @life_points <= 0
  end

  def attacks(other_player)
    # Attaque un autre player
    puts "#{@name} attaque #{other_player.name}"
    damage_received = compute_damage
    puts "il lui inflige #{damage_received} points de dommages"
    other_player.gets_damage(damage_received)
  end

  def compute_damage
    # Calcule aleatoirement le nombre de points de dommage
    rand(1..6)
  end
end

# Definit un joueur humain qui herite de la classe joueur
class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    # Cree un nouveau player humain avec une arme de niveau 1, 100 points de vie
    @name = name
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    # Affiche l'etat du joueur humain
    print "#{@name} a #{@life_points} points de vie "
    puts "et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    # Calcule aleatoirement les dommages
    # en les multipliant par le niveau de l'arme
    rand(1..6) * @weapon_level
  end

  def search_weapon
    # Cherche une nouvelle arme
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts 'Youhou ! elle est meilleure que ton arme actuelle : tu la prends.'
    else
      puts "Mais... elle n'est pas mieux que ton arme actuelle ..."
    end
  end

  def search_health_pack
    # Cherche des packs de points de vie
    search = rand(1..6)
    if search == 1
      puts "Tu n'as rien trouvé ..."
    elsif search == 6
      puts 'Waow, tu as trouvé un pack de +80 points de vie !'
      @life_points + 80 > 100 ? @life_points = 100 : @life_points += 80
    else
      puts 'Bravo, tu as trouvé un pack de +50 points de vie !'
      @life_points + 50 > 100 ? @life_points = 100 : @life_points += 50
    end
  end
end
