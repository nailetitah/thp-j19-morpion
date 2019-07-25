class Grid
  attr_accessor :grid, :grid_table
  @@grid = []
  def self.create_grid
  puts "Voici la table de jeu :"
  @@grid = [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']]
  @@grid_table = Terminal::Table.new :rows => @@grid
  puts @@grid_table
  end
  
  def self.grid_changes_kv(x, y, choice)
    @@grid[x][y].replace(choice)
    @@grid_table = Terminal::Table.new :rows => @@grid
    puts @@grid_table
  end

  def self.grid_changes(choice, symbol)
    @@grid.flatten.each {|el| 
      if el == "#{choice}" 
        el.replace symbol
      end 
      }
    @@grid_table = Terminal::Table.new :rows => @@grid
    puts @@grid_table
  end

  def self.winner_grid?(symbol = "")
    if @@grid[0][0] == symbol && @@grid[0][1] == symbol && @@grid[0][2] == symbol
      return true
    elsif @@grid[1][0] == symbol && @@grid[1][1] == symbol && @@grid[1][2] == symbol
      return true 
    elsif @@grid[2][0] == symbol && @@grid[2][1] == symbol && @@grid[2][2] == symbol
      return true 
    # Colonnes 
    elsif @@grid[0][0] == symbol && @@grid[1][0] == symbol && @@grid[2][0] == symbol
      return true
    elsif @@grid[0][1] == symbol && @@grid[1][1] == symbol && @@grid[2][1] == symbol
      return true
    elsif @@grid[0][2] == symbol && @@grid[1][2] == symbol && @@grid[2][2] == symbol
      return true 
    # Diagonales 
    elsif @@grid[0][0] == symbol && @@grid[1][1] == symbol && @@grid[2][2] == symbol
      return true
    elsif @@grid[0][2] == symbol && @@grid[1][1] == symbol && @@grid[2][0] == symbol
      return true
    else return false
    end
  end

  def self.show_grid
    puts @@grid_table
  end

end