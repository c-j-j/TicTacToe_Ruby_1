module TTT
  class ComputerPlayer

    attr_reader :mark

    WIN_SCORE = 10
    LOSE_SCORE = -10
    DRAW_SCORE = 0

    def initialize(board, mark)
      @board = board
      @mark = mark
    end

    def next_move
      @opponent = @board.find_opponent(self, :new_opponent)
      minimax(@board, true)
      return @best_move
    end

    def minimax(board, maximizing_player=true)
      if board.game_over?
        return calculate_score(board) 
      end

      if maximizing_player
        scores = calculate_child_scores(board, self, !maximizing_player)
        max_value = scores.values.max
        @best_move = scores.key(max_value) #TODO Do not like this
        return max_value
      else
        scores = calculate_child_scores(board, @opponent, !maximizing_player)
        return scores.values.min
      end
    end

    private

    def calculate_child_scores(board, player, maximizing_player)
      scores = {}
      board.empty_positions.each do |empty_position|
        new_board = create_new_board_with_move(board, player, empty_position)
        scores[empty_position] = minimax(new_board, maximizing_player)
      end
      return scores
    end

    def create_new_board_with_move(board, player, empty_position)
      new_board = Board.new(board.positions)
      new_board.add_move(player, empty_position)
      return new_board
    end

    def calculate_score(board)
      return DRAW_SCORE if board.is_a_tie?

      if board.has_been_won?
        if this_player_has_won?(board)
          return WIN_SCORE
        else
          return LOSE_SCORE
        end
      end
    end

    def this_player_has_won?(board)
      board.winner == self
    end

  end
end
