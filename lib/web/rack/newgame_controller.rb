require 'rack'
require 'lib/game'

module TTT
  module Web
    class NewGameController

      def initialize(web_interface)
        @web_interface = web_interface
      end

      def call(env)
        req = Rack::Request.new(env)
        game = prepare_game(extract_game_type(req), extract_board_size(req))
        save_game_in_session(req, game)
        [200, {'Content-Type' => 'text/html'}, [@web_interface.play_turn(game)]]
      end

      private

      def save_game_in_session(req, game)
        req.session[:game] = game
      end

      def prepare_game(game_type, board_size)
        TTT::Game.build_game(@web_interface, game_type, board_size)
      end

      def extract_game_type(request)
        request.params['game_type']
      end

      def extract_board_size(request)
        request.params['board_size'].to_i
      end
    end
  end
end
