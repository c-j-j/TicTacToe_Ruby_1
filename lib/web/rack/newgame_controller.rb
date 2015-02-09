require 'rack'
require 'lib/game'
require 'lib/async_interface'

module TTT
  module Web
    class NewGameController

      PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

      def call(env)
        req = Rack::Request.new(env)
        game = prepare_game(extract_game_type(req), extract_board_size(req))
        save_game_in_session(req, game)
        redirect_to_play_turn_page
      end

      private

      def redirect_to_play_turn_page
        response = Rack::Response.new
        response.redirect('/play_move')
        response.finish
      end

      def save_game_in_session(req, game)
        req.session[:game] = game
      end

      def prepare_game(game_type, board_size)
        TTT::Game.build_game(TTT::AsyncInterface.new, game_type, board_size)
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
