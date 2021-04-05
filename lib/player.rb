class Player
  attr_accessor :answers, :symbol, :name

  @@choices = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def initialize(name = nil)
    @name = name
    @answers = []
    @symbol = nil
    
  end

  def self.choices
    @@choices
  end

  def make_choice(choice = nil)
    p "the player is making a choice = #{choice}"
    if @@choices.include?(choice.to_i)
        @answers.push(choice.to_i)
        @@choices[choice.to_i-1] = @symbol
    else
        return "#{choice} - is is not a good choice."
    end
    p "the player = #{self}"
  end

  def to_s
    "Player = #{@name} with answers = #{@answers} and symbol = #{@symbol} choices = #{@@choices}"
  end
end
