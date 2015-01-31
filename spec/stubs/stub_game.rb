module TTT
  class StubGame

    def initialize
      @registered_moves = []
      @game_over = false
      @move_valid = true
    end

    def register_game_over
      @game_over = true
    end
    def game_over?
      @game_over_called = true
      @game_over
    end

    def game_over_called?
      @game_over_called
    end

    def all_moves_are_invalid
      @move_valid = false
    end

    def move_valid?(position)
      @move_valid_called = true
      @move_valid
    end

    def move_valid_called?
      @move_valid_called
    end

    def play_turn(position)
      @play_turn_called = true
    end

    def play_turn_called?
      @play_turn_called
    end

    def won?
      @won_called = true
    end

    def won_called?
      @won_called
    end

    def register_winner(winner)
      @winner = winner
      register_game_over
    end

    def winner
      @winner_called = true
      @winner
    end

    def winner_called?
      @winner_called
    end

    def register_draw
      @draw = true
      register_game_over
    end

    def draw?
      @draw_called = true
      @draw
    end

    def draw_called?
      @draw_called
    end
  end
end
