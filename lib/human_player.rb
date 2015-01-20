module TTT
  class HumanPlayer

    PLAYER_INVALID_MOVE_MESSAGE = "Not a valid move. Try again..." 

    attr_accessor :mark

    def initialize(display, board, mark)
      @display = display
      @board = board
      @mark = mark
    end

    def next_move
      invalid_move = true
      while invalid_move
        user_input = @display.get_user_input
        if is_move_valid(user_input)
          invalid_move = false
        else
          @display.print_invalid_message
        end
      end
      user_input.to_i
    end

    def is_move_valid(user_input)
      input_between_0_and_8(user_input) && @board.is_move_valid?(user_input.to_i)
    end

    def input_between_0_and_8(user_input)
      user_input.match(/[0-8]/) 
    end
  end
end
