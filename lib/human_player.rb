module TTT
  class HumanPlayer

    attr_reader :mark

    def initialize(display, board, mark)
      @display = display
      @board = board
      @mark = mark
    end

    def next_move
      while true
        user_input = @display.get_user_input
        if @board.is_move_valid?(user_input.to_i)
          break
        else
          @display.print_invalid_message
        end
      end
      user_input.to_i
    end
  end
end
