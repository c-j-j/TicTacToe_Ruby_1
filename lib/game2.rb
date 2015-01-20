module TTT
  class Game2

    attr_accessor :current_player

    def initialize(board, display, player_1, player_2)
      @board = board
      @display = display
      @player_1 = player_1
      @player_2 = player_2
      @current_player = @player_1
    end

    def play
      until @board.game_over?
        play_next_turn
        swap_current_player unless @board.game_over?
      end

      if @board.is_a_tie
        @display.print_tie_message
      else
        @display.print_winner_message(@board.find_winner)
      end
    end

    def play_next_turn
      @display.render_board(@board)
      @display.print_next_player_to_go(@player_1)
      @board.add_move(@player_1, @player_1.next_move)
    end

    def swap_current_player
      if @current_player == @player_1
        @current_player = @player_2
      else
        @current_player = @player_1
      end
    end
  end
end
