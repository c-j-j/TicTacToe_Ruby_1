module TTT
  class ComputerPlayer

    attr_reader :mark

    WIN_SCORE = 10
    LOSE_SCORE = -10
    DRAW_SCORE = 0
    DEPTH_REACHED_SCORE = -5
    INFINITY = 10000
    MINUS_INFINITY = -INFINITY
    INITIAL_DEPTH = 6 #depth of 6 ensures computer player still takes best moves during 3x3
    INDETERMINATE_MOVE_ERROR = 'Unable to determine next move. Board may be in terminal state already'

    def initialize(mark, opponent_mark)
      @mark = mark
      @opponent_mark = opponent_mark
    end

    def next_move(board)
      next_move = negamax(board, @mark).position
      raise INDETERMINATE_MOVE_ERROR if next_move.nil?
      next_move
    end

    def negamax(board, current_player_mark, depth=INITIAL_DEPTH, alpha=MINUS_INFINITY, beta=INFINITY)
      if board.game_over? || depth == 0
        return Move.new(calculate_score(board, current_player_mark))
      end

      scores = {}
      board.empty_positions.each do |empty_position|
        new_board = create_new_board_with_move(board, current_player_mark, empty_position)
        scores[empty_position] = -(negamax(new_board, find_next_player(current_player_mark), depth - 1, -beta, -alpha)
                                   .score)

        alpha = [alpha, scores[empty_position]].max
        break if alpha >= beta
      end

      return Move.new(find_max_value(scores), find_best_move(scores))
    end

    private

    def find_max_value(scores)
      scores.values.max
    end

    def find_best_move(scores)
      scores.key(find_max_value(scores))
    end

    def find_next_player(current_player_mark)
      if current_player_mark == @mark
        @opponent_mark
      else
        @mark
      end
    end

    def create_new_board_with_move(board, mark, empty_position)
      new_board = board.copy
      new_board.add_move(mark, empty_position)
      return new_board
    end

    def calculate_score(board, mark)
      return DEPTH_REACHED_SCORE unless board.game_over?

      return DRAW_SCORE if board.draw?

      if mark_has_won?(board, mark)
        return WIN_SCORE
      else
        return LOSE_SCORE
      end
    end

    def mark_has_won?(board, mark)
      board.winner == mark
    end
  end

  class Move < Struct.new(:score, :position)
  end
end
