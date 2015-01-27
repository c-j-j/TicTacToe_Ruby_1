module TTT
  class HumanPlayer

    attr_reader :mark

    def initialize(display, board, mark)
      @display = display
      @board = board
      @mark = mark
    end

    def next_move
      @display.get_user_move(@board)
    end
  end
end
