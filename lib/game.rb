module TTT
  class Game

    TIE_MESSAGE = 'Game is a tie.'
    WINNING_MESSAGE = '%s has won.'

    def initialize(cli_renderer, board, player_1, player_2)
      @cli_renderer = cli_renderer
      @board = board
      @player_1 = player_1
      @player_2 = player_2
    end

    def game_over?
      @board.game_over?
    end

    def update_with_player_1_input
      @board.add_move(@player_1, @player_1.next_move)
    end

    def update_with_player_2_input
      @board.add_move(@player_2, @player_2.next_move)
    end

    def render
      @cli_renderer.render(@board)
    end

    def display_outcome
      if(@board.is_a_tie?)
        @cli_renderer.render(TIE_MESSAGE)
      else
        @cli_renderer.render(WINNING_MESSAGE % @board.find_winner)
      end
    end
  end
end
