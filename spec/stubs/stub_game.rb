module TTT
  class StubGame

    attr_accessor :board

    def initialize
      @registered_moves = []
      @game_over = false
      @move_valid = true
      @play_called = false
      @continue_game_called = false
      @board = TTT::Board.new(3)
    end

    def register_game_over
      @game_over = true
    end

    def play_turn_ends_game
      @play_turn_ends_game = true
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

    def play
      @play_called = true
    end

    def play_called?
      @play_called
    end

    def continue_game_with_move(position)
      @continue_game_called = true
    end

    def continue_game_called?
      @continue_game_called
    end

    def won?
      @won_called = true
    end

    def won_called?
      @won_called
    end

    def number_of_positions
      @board.number_of_positions
    end

    def row_size
      @board.rows.size
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

    def play_turn(move = nil)
      @game_over = true if @play_turn_ends_game
      @play_turn_called = true
    end

    def play_turn_called?
      @play_turn_called
    end

    def model_data_called?
      @model_data_called
    end

    def set_model_data(game_model_data)
      @game_model_data = game_model_data
    end

    def model_data
      @model_data_called = true
      @game_model_data
    end
  end
end
