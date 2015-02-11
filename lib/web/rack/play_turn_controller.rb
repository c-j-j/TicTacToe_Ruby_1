require 'rack'
require 'async_interface'
require 'web/rack/url_helper'
require 'ui/constants'

module TTT
  module Web
    class PlayTurnController
      include Rack::Utils

      PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

      attr_reader :refresh_page
      attr_reader :cell_size
      attr_reader :game_model_data
      attr_reader :next_turn_url
      attr_reader :status

      def initialize
        @refresh_page = false
      end

      def call(env)
        request = Rack::Request.new(env)
        game = build_game_from_params(request)
        process_turn(game, extract_position_from_param(request))
        calcuate_common_fields(request, game)
        generate_response
      end

      def process_turn(game, played_position)
        if game.move_valid?(played_position)
          game.play_turn(played_position)
          @status = determine_status(game.model_data)
        else
          @status = TTT::UI::INVALID_MOVE_MESSAGE
        end
        return game
      end

      def determine_status(game_model_data)
        status = game_model_data.status
        if status == TTT::Game::DRAW
          TTT::UI::TIE_MESSAGE
        elsif status == TTT::Game::WON
          TTT::UI::WINNING_MESSAGE % game_model_data.winner
        else
          TTT::UI::NEXT_PLAYER_TO_GO % game_model_data.current_player_mark
        end
      end

      def determine_cell_size(game_model_data)
        if game_model_data.row_size == 4
          '24%'
        elsif game_model_data.row_size == 3
          '32%'
        end
      end

      def refresh_required?(game_model_data)
        game_model_data[:current_player_is_computer] && !game_over?(game_model_data)
      end

      private

      def calcuate_common_fields(request, game)
          @game_model_data = game.model_data
          @refresh_page = refresh_required?(@game_model_data)
          @cell_size = determine_cell_size(@game_model_data)
          @next_turn_url = TTT::Web::URLHelper.play_turn_url(extract_game_type(request), game.board_positions)
      end

      def game_over?(game_model_data)
        game_model_data[:status] == TTT::Game::WON || game_model_data[:status] == TTT::Game::DRAW
      end

      def generate_response
        [200, {'Content-Type' => 'text/html'},
         [ERB.new(File.new(PLAY_VIEW, "r").read).result(binding) ]]
      end

      def build_game_from_params(request)
        game_type = extract_game_type(request)
        board = TTT::Board.new_board_with_positions(JSON.parse(request.params['board']))
        TTT::Game.build_game_with_board(TTT::AsyncInterface.new, game_type, board)
      end

      def extract_game_type(request)
        request.params['game_type']
      end

      def extract_position_from_param(req)
        position = req.params['position']
        position.to_i unless position.nil?
      end
    end
  end
end
