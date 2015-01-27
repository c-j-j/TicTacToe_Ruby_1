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
      @opponent_mark = @board.find_opponent(@mark, :new_opponent)
      negamax(@board, @mark).position
    end

    def negamax(board, current_player_mark)
      if board.game_over?
        return Move.new(calculate_score(board, current_player_mark), :ignore)
      end

      scores = {}
      board.empty_positions.each do |empty_position|
        new_board = create_new_board_with_move(board, current_player_mark, empty_position)
        scores[empty_position] = -(negamax(new_board, find_next_player(current_player_mark)).score)
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
      new_board = Board.new(board.positions)
      new_board.add_move(mark, empty_position)
      return new_board
    end

    def calculate_score(board, mark)
      return DRAW_SCORE if board.draw?

      if board.won?
        if mark_has_won?(board, mark)
          return WIN_SCORE
        else
          return LOSE_SCORE
        end
      end
    end

    def mark_has_won?(board, mark)
      board.winner == mark
    end

  end

  class Move < Struct.new(:score, :position)
  end
end
