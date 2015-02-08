require 'rack'
require 'lib/game'

module TTT
  module Web
    class NewGameController

      PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

      def initialize(web_interface)
        @web_interface = web_interface
      end

      def call(env)
        req = Rack::Request.new(env)
        game = prepare_game(extract_game_type(req), extract_board_size(req))
        save_game_in_session(req, game)
        @game_response = @web_interface.play_turn(game)
        [200, {'Content-Type' => 'text/html'}, [generate_response]]
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

      private

      def generate_response
        ERB.new(File.new(PLAY_VIEW, "r").read).result(binding)
      end
    end
  end
end
