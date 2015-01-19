module TTT
  class Minimax
    def initialize(board)
      @board = board
    end

    def minimax 
      if @board.game_over?
        puts 'game is over'
        return 0
      else
        puts 'game is not over'
      end
    end
  end
end
