class Index
  def self.welcome_message
      rows_start = [["JEU DU MORPION"]]
      table_start = Terminal::Table.new :rows => rows_start
      puts table_start
  end
end

