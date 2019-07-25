class Player
  attr_accessor :name, :num, :moves, :symbol, :players
  @@players = []
  def initialize(name, num, moves, symbol)
    @name = name
    @moves = moves.to_i
    @symbol = symbol
    @@players << self
  end 

  def self.ask_player_names
    print "Qui est le Joueur numéro 1 ? "
    player1 = new_player(player_input, 1, 5, "❌")
    print "Parfait, et le Joueur numéro 2 ? "
    player2 = new_player(player_input, 2, 4, "⭕")
    puts "***"
    puts "Très bien, #{player1.name} jouera avec ❌ et #{player2.name} avec ⭕"
  end

  def self.get_player1
    @@players.each { |player| return player if player.num == 1}
  end

  def self.new_player(input, num, move, symbol)
    Player.new(input, num, move, symbol)
  end
  
  def self.player_input
    gets.chomp
  end

  def player_choice_asked # Terminer
    print "Quel choix veux-tu faire ? "
    gets.chomp
  end


  def self.all
    @@players
  end

  def self.reset_players
    @@players.clear
  end

  def self.find_by_name(player_name)
    self.all.map { |obj| return obj if obj.player_name == player_name }
  end

end

