module TTT
  class StubGame

    def initialize
      @registered_moves = []
    end

    def game_over?
      @game_over_called = true
      false
    end

    def game_over_called?
      @game_over_called
    end

    def register_move(position)
      @registered_moves << position
    end

    def move_registered?(position)
      @registered_moves.include?(position)
    end
  end
end
