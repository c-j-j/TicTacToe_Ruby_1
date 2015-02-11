require 'rack'
require 'tictactoe'
require 'lib/web/rack/url_helper'

module TTT
  module Web
    class NewGameController
      include Rack::Utils

      def call(env)
        req = Rack::Request.new(env)
        game_type = extract_game_type(req)
        redirect_to_play_turn_page(prepare_game(game_type, extract_board_size(req)), game_type)
      end

      private

      def redirect_to_play_turn_page(game, game_type)
        response = Rack::Response.new
        response.redirect(TTT::Web::URLHelper.play_turn_url(game_type, game.board_positions))
        response.finish
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
