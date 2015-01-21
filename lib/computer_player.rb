module TTT
  class ComputerPlayer

    WIN_SCORE = 10
    LOSE_SCORE = -10
    DRAW_SCORE = 0

    def initialize(board)
      @board = board
    end

    def next_move
      minimax(@board, true)
      return @best_move
    end

    def minimax(board=@board, maximizing_player=true)
      if board.game_over?
        return calculate_score 
      end

      if maximizing_player
        scores = calculate_child_nodes(board, self, !maximizing_player)
        max_value = scores.values.max
        @best_move = scores.key(max_value) #TODO Do not like this
        return max_value
      else
        scores = calculate_child_nodes(board, :opponent, !maximizing_player)
        return scores.values.min
      end
    end

    def calculate_child_nodes(board, player, maximizing_player)
      scores = Hash.new
      board.empty_positions.each do |empty_position|
        new_board = Board.new(board)
        new_board.add_move(player, empty_position)
        scores[empty_position] = minimax(new_board, maximizing_player)
      end

      return scores
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
