class Player

    attr_accessor :answers, :symbol

    def initialize(name)
        @name = name
        @answers = []
        @symbol = nil
    end

    def to_s
        "Player = #{@name} with answers = #{@answers} and symbol = #{@symbol}"
    end

end