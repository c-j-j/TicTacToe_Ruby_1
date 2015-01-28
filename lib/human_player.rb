module TTT
  class HumanPlayer

    attr_reader :mark

    def initialize(user_interface, board, mark)
      @user_interface = user_interface
      @board = board
      @mark = mark
    end

    def next_move
      @user_interface.get_user_move(@board)
    end
  end
end
