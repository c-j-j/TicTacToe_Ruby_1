module TTT
  class StubInterface
    def initialize
      @invalid_message_count = 0
      @print_tie_message_count = 0
      @print_next_player_to_go_results = []
      @print_winner_message_results = []
      @print_board_results = []
    end

    def play_turn(game)
      {:response => 'data'}
    end

    def specify_game_type(game_type)
      @game_type = game_type
    end

    def specify_board_size(board_size)
     @board_size = board_size
    end

    def get_board_size(*options)
      @board_size
    end

    def get_game_type(game_types)
      @game_type
    end

    def print_invalid_message
      @invalid_message_count += 1
    end

    def print_board(board)
      @print_board_results << board
    end

    def board_printed?
      @print_board_results.size > 0
    end

    def next_player_printed?
      @print_next_player_to_go_results.size > 0
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

    def winner_message_printed?
      @print_winner_message_results.size > 0
    end

    def tie_message_printed?
      @print_tie_message_count > 0
    end

    def set_user_moves(*move)
      @next_user_move = move
    end

    def get_user_move(board)
      @next_user_move.shift
    end
  end
end
