module TTT
  class StubDisplay

    attr_accessor :invalid_message_count
    attr_accessor :print_tie_message_count
    attr_accessor :print_next_player_to_go_results
    attr_accessor :print_winner_message_results
    attr_accessor :render_board_results

    def initialize
      @renders = []
      @invalid_message_count = 0
      @print_tie_message_count = 0
      @print_next_player_to_go_results = []
      @print_winner_message_results = []
      @render_board_results = []
    end

    def render(output_string)
      @renders << output_string 
    end

    def specify_game_type(game_type)
      @game_type = game_type
    end

    def specify_first_player(first_player)
      @first_player = first_player
    end

    def get_first_player
      @first_player
    end

    def get_game_type
      @game_type
    end

    def print_invalid_message
      @invalid_message_count += 1
    end

    def render_board(board)
      @render_board_results << board
    end

    def print_next_player_to_go(player)
      @print_next_player_to_go_results << player
    end

    def print_tie_message
      @print_tie_message_count += 1
    end

    def print_winner_message(player)
      @print_winner_message_results << player
    end

    def get_previous_renders
      @renders
    end

    def set_user_input(*mocked_user_input)
      @user_input = mocked_user_input
    end

    def get_user_input
      @user_input.shift
    end
  end
end
