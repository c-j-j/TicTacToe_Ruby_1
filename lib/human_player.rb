module TTT
  class HumanPlayer
    
    PLAYER_TURN_MESSAGE = "%s's turn..." 
    PLAYER_INVALID_MOVE_MESSAGE = "Not a valid move. %s's turn..." 

    def initialize(cli_renderer, board, mark)
      @cli_renderer = cli_renderer
      @board = board
      @mark = mark
    end

    def next_move
      invalid_move = true
      @cli_renderer.render(PLAYER_TURN_MESSAGE % self)
      while invalid_move
        user_input = @cli_renderer.get_user_input
        if is_move_valid(user_input)
          invalid_move = false
        end

        @cli_renderer.render(PLAYER_INVALID_MOVE_MESSAGE % self)
      end
      user_input.to_i
    end

    def is_move_valid(user_input)
      user_input.match(/[0-8]/) && @board.is_move_valid?(user_input.to_i)
    end

    def to_s
      @mark
    end
  end
end
