require 'rack'
require 'lib/tictactoe_game'
require 'lib/async_interface'
require 'json'

module TTT
  module Web
    class NewGameController
      include Rack::Utils

      def call(env)
        req = Rack::Request.new(env)
        game_type = extract_game_type(req)
        game = prepare_game(game_type, extract_board_size(req))
        save_game_in_session(req, game)
        redirect_to_play_turn_page(game, game_type)
      end

      private

      def redirect_to_play_turn_page(game, game_type)
        response = Rack::Response.new
        response.redirect("/play_move?game_type=#{escape(game_type)}&board=#{escape(game.board_positions.to_json)}")
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
    end
  end
end
