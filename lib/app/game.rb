class Game
  @@winner_symbol = ""
  @@choices_id = []

  def initialize(choices = Choices.all, players = Player.all)
    Index.welcome_message
    Player.ask_player_names
    Grid.create_grid
    get_choices_id
    @choices = choices
    @players = players
  end

  def game_start 
    puts "Vous êtes prêts ?"
    follow_script
    puts "C'est parti ! "
    i = 0
    loop do
      # Affichage des rounds
      i += 1
      rows_round = [["Round", i]]
      table_round = Terminal::Table.new :rows => rows_round
      puts table_round
      # Boucle de jeu pour chaque joueur 
      @players.each { |player|
        # Phase de jeu
        round(player)  if @choices.length > 0 && Grid.winner_grid?(@@winner_symbol) != true
          # Condition de victoire
          if Grid.winner_grid?(player.symbol) == true
              rows_end = [["Victoire de #{player.name} !"]]
              table_end = Terminal::Table.new :rows => rows_end
              puts table_end
          @@winner_symbol = player.symbol
          end
       }
       # Fin de la boucle en cas de match nul ou de victoire
      if @choices.length == 0 && Grid.winner_grid?(@@winner_symbol) != true
          rows_draw = [["Match nul"]]
          table_draw = Terminal::Table.new :rows => rows_draw
          puts table_draw
        break
      elsif Grid.winner_grid?(@@winner_symbol) == true
        break
      end
    end
    Done.end_game
    # Proposition de rejouer
    Game.new_game
  end

  def round(player)
    puts "Au tour de #{player.name} ! Tu as #{player.moves} coups à jouer."
    puts "Ton symbole est #{player.symbol}"
    puts "Sur quelle case souhaites-tu jouer ?"
    # On affiche la grille pour laisser le choix au joueur
    Grid.show_grid
    # On récupère le choix du joueur
    player_choice_returned = menu_choice
    # Le choix du joueur modifie la grille de jeu
    player_grid_choice(player_choice_returned, player.symbol)
    # On retire le choix au niveau de la grille et un coup au joueur
    choice_to_remove = Choices.find_by_id(player_choice_returned)
    remove_possibility(choice_to_remove)
    player.moves -= 1
    follow_script
  end

  def menu_choice(input = "")
    loop do
      print "> "
      input = gets.chomp.to_i
      # On conditionne le choix du joueur à un des choix restants
      if valid_input?(input) == true
        puts "Voici ton choix : "
        # On redire ce choix
        remove_choice_id(input)
        return input
        break
      else
        puts "Fais ton choix parmi ceux proposées !"
      end
    end
  end

  def valid_input?(input)
    @@choices_id.include? input
  end

  def get_choices_id
    Choices.all.map { |obj| @@choices_id << obj.id }
  end

  def player_grid_choice(choice, symbol)
      Grid.grid_changes(choice, symbol)
  end

  def remove_possibility(choice)
      @choices.delete(choice)
  end

  def remove_choice_id(input)
     @@choices_id.delete(input)
  end

  def self.new_game
    loop do 
    print "[Entrée] pour rejouer "
    choice = gets
      if choice == "\n"
        break
      end
    end
    Player.reset_players
    Choices.reset_choices
    self.perform
  end

  # Un petit script pour aérer le jeu
  def follow_script
  loop do 
    print "[Entrée] pour continuer "
    choice = gets
      if choice == "\n"
        break
      else
        print "[Entrée] pour continuer "
      end
    end
  end

  def self.perform
    Choices.new_game_choices
    Game.new.game_start
    # Choices.initialize_choices
  end

end