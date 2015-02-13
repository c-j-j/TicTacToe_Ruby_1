require 'ui/constants'

module TTT
  class GamePresenter
    attr_accessor :board, :state, :winner, :current_player_mark, :current_player_is_computer, :row_size

    def computer_has_next_turn?
      @current_player_is_computer && !game_over?
    end

    def status
      if @state == TTT::Game::DRAW
        TTT::UI::TIE_MESSAGE
      elsif @state == TTT::Game::WON
        TTT::UI::WINNING_MESSAGE % @winner
      else
        TTT::UI::NEXT_PLAYER_TO_GO % @current_player_mark
      end
    end

    def game_over?
      @state == TTT::Game::WON || @state == TTT::Game::DRAW
    end

    def cell_size
      return '24%' if row_size == 4
      '32%'
    end

    class Builder
      def initialize
        @game_presenter = GamePresenter.new
      end

      def with_board(board)
        @game_presenter.board = board
        return self
      end

      def with_state(state)
        @game_presenter.state = state
        return self
      end

      def with_winner(winner)
        @game_presenter.winner = winner
        return self
      end

      def with_current_player_mark(current_player_mark)
        @game_presenter.current_player_mark = current_player_mark
        return self
      end

      def with_current_player_is_computer(current_player_is_computer)
        @game_presenter.current_player_is_computer = current_player_is_computer
        return self
      end

      def with_row_size(row_size)
        @game_presenter.row_size = row_size
        return self
      end

      def build
        @game_presenter
      end
    end
  end
end
