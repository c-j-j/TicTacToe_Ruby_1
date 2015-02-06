require 'lib/ui/constants'
require 'lib/game'
require 'erb'

module TTT
  module Web
    class WebInterface
      attr_reader :board
      attr_reader :status

      PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

      def play_turn(game)
        game.play2
        generate_response
      end

      def get_user_move(board)
        Game::MOVE_NOT_AVAILABLE
      end

      def submit_move(game, move)
         game.play_turn(move)
      end

      def print_board(board)
        @board = board
      end

      def print_winner_message(winner)
        @status = TTT::UI::WINNING_MESSAGE % winner
      end

      def print_tie_message
        @status = TTT::UI::TIE_MESSAGE
      end

      def print_next_player_to_go(next_player)
        @status = TTT::UI::NEXT_PLAYER_TO_GO % next_player
      end

      def print_invalid_move_message
        @status = TTT::UI::INVALID_MOVE_MESSAGE
      end

      private

      def generate_response
        ERB.new(File.new(PLAY_VIEW, "r").read).result(binding)
      end
    end
  end
end
