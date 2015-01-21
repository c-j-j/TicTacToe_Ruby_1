module TTT
  class ComputerPlayer

    WIN_SCORE = 10
    LOSE_SCORE = -10
    DRAW_SCORE = 0

    def initialize(board)
      @board = board
    end

    def next_move
      minimax(board, true)
      return @move
    end

    def minimax(board=@board, maximising_player=true)
      if board.game_over?
        return calculate_score 
      end

      if maximising_player
        max_value = -100
        scores = Hash.new
        board.empty_positions.each do |position|
          new_board = Board.new(board)
          new_board.add_move(self, position)
          score = minimax(new_board, false)
          scores.put(position, score)
          max_value = [max_value, score].max
        end
        @move = scores.key(max_value) 
        return max_value
      else
        min_value = 100

        board.empty_positions.each do |position|
          new_board = Board.new(board)
          new_board.add_move(:opponent, position)
          score = minimax(new_board, true)
          min_value = [min_value, score].min
        end
        return min_value
      end

    end

    def calculate_score
      return DRAW_SCORE if @board.is_a_tie?

      if @board.has_been_won?
        if this_player_has_won?
          return WIN_SCORE
        else
          return LOSE_SCORE
        end
      end
    end

    def this_player_has_won?
      @board.winner == self
    end
  end
end
