module TTT
  class BoardHelper
    def initialize(board)
      @board = board
    end

    def populate_board_with_tie(player_1, player_2)
     player_1_moves = [0, 2, 5, 7, 6]  
     player_2_moves = [1, 3, 4, 8]  

     add_moves_to_board(player_1_moves, player_1)
     add_moves_to_board(player_2_moves, player_2)
    end

    def populate_board_with_win(winning_player)
      add_moves_to_board([0, 1, 2], winning_player)
    end

    def populate_board_with_loss
      
      add_moves_to_board([0, 1, 2], 'some other player')
    end

    def add_moves_to_board(moves, player)
      moves.each do |move|
        @board.add_move(player, move)
      end
    end
  end
end
