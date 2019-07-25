class Choices
  attr_accessor :id, :choices_left, :choices_id
  @@choices_left = []
  @@choices_id = []

  def initialize(id)
    @id = id
    @@choices_id << self.id
  end

  def self.new_game_choices
    (1..9).each { |i| @@choices_left << Choices.new(i) }
  end

  def self.all
    @@choices_left
  end

  def self.find_by_id(id)
    self.all.map { |obj| return obj if obj.id == id }
  end

  def self.get_choices_id
    @@choices_id
  end

  def self.reset_choices
    @@choices_left.clear
  end

end