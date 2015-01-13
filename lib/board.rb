module TTT
  class Board
    def initialize
      @positions = Array.new(9)
    end
    def add_move(player, position)
     @positions[position] = player 
    end

    def get_player_in_position(position)
      @positions[position]
    end
  end
end
