module TTT
  class Game

    TIE_MESSAGE = 'Game is a tie.'
    WINNING_MESSAGE = '%s has won.'

    def initialize(display, board, player_1, player_2)
      @display = display
      @board = board
      @player_1 = player_1
      @player_2 = player_2
      @current_player = player_1
    end

    def game_over?
      @board.game_over?
    end

    def update_with_next_player_move
      @board.add_move(@current_player, @current_player.next_move)
      swap_current_player
    end

    def swap_current_player
      if @current_player == @player_1
        @current_player = @player_2
      else
        @current_player = @player_1
      end
    end

    def render
      @display.render_board(@board)
    end

    def display_outcome
      if(@board.is_a_tie?)
        @display.render(TIE_MESSAGE)
      else
        @display.render(WINNING_MESSAGE % @board.find_winner)
      end
    end
  end
end
