module TTT
  class Game

    attr_accessor :current_player
    attr_reader :board

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

      @display.print_tie_message if @board.is_a_tie?
      @display.print_winner_message(@board.winner) if @board.has_been_won?
    end

    def play_next_turn
      @display.render_board(@board)
      @display.print_next_player_to_go(@current_player)
      @board.add_move(@current_player, @current_player.next_move)
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
