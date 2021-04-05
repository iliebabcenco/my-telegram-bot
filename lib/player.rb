class Player

    attr_accessor :answers, :symbol, :name

    def initialize(name=nil)
        @name = name
        @answers = []
        @symbol = nil
    end

    def to_s
        "Player = #{@name} with answers = #{@answers} and symbol = #{@symbol}"
    end

end