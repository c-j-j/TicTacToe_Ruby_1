module TTT
  class HumanPlayer

    attr_reader :mark

    def initialize(user_interface, mark)
      @user_interface = user_interface
      @mark = mark
    end

    def next_move(board)
      @user_interface.get_user_move(board)
    end
  end
end
