class Player
  attr_accessor :answers, :symbol, :name

  @choices = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def initialize(name = nil)
    @name = name
    @answers = []
    @symbol = nil
  end

  class << self
    attr_reader :choices
  end

  def self.reset_choices
    @choices = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def make_choice(choice = nil)
    return unless Player.choices.include?(choice.to_i) || Player.choices.include?(choice)

    @answers.push(choice.to_i)
    Player.choices[choice.to_i - 1] = @symbol
  end

  def to_s
    "Player = #{@name} with answers = #{@answers} and symbol = #{@symbol}"
  end
end
