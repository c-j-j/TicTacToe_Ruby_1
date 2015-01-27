module TTT
  class BoardHelper
    def initialize(board)
      @board = board
    end

    def populate_board_with_tie(player_1_mark, player_2_mark)
     player_1_mark_moves = [0, 2, 5, 7, 6]
     player_2_mark_moves = [1, 3, 4, 8]

     add_moves_to_board(player_1_mark_moves, player_1_mark)
     add_moves_to_board(player_2_mark_moves, player_2_mark)
    end

    def populate_board_with_win(winning_player_mark)
      add_moves_to_board([0, 1, 2], winning_player_mark)
    end

    def populate_board_with_loss
      add_moves_to_board([0, 1, 2], 'some other mark')
    end

    def add_moves_to_board(moves, mark)
      moves.each do |move|
        @board.add_move(mark, move)
      end
    end
  end
end
