require 'telegram/bot'
#require './bin/main.rb'

module Lgtictac

    @@play = false

    def self.play?(bool=nil)
        raise ArgumentError unless !!bool == bool
        @@play = bool
        @@play
    end

    def self.check_message(mess = nil)
      case mess
        when '/start', 'y', 'yes', 'yeah', 'yep'
          @@play = true
          return 'start'
        when '1', '2', '3', '4', '5', '6', '7', '8', '9'
          p "there is a number = #{mess} and play is = #{@@play}"
          if @@play
            return 'numbers'
          end
        when '/end', '/close', 'no', 'end'
          @@play = false
          return 'end'
        else
          return 'numbers-error'
        end
      end
    


end