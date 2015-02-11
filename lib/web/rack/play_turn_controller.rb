require 'rack'
require 'async_interface'
require 'json'

module TTT
  module Web
    class PlayTurnController
      include Rack::Utils

      PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

      attr_reader :refresh_page
      attr_reader :cell_size
      attr_reader :game_model_data
      attr_reader :board_param
      attr_reader :game_type_param

      def initialize
        @refresh_page = false
      end

      def call(env)
        request = Rack::Request.new(env)
        game = build_game_from_params(request)
        game.play_turn(extract_position_from_param(request))
        @game_model_data = game.model_data

        @refresh_page = refresh_required?(@game_model_data)
        @cell_size = determine_cell_size(@game_model_data)
        @board_param = escape(game.board_positions.to_json)
        @game_type_param = escape(extract_game_type(request))

        [200,
         {'Content-Type' => 'text/html'},
         [generate_response]]
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

      def game_over?(game_model_data)
        game_model_data[:status] == TTT::Game::WON || game_model_data[:status] == TTT::Game::DRAW
      end

      def generate_response
        ERB.new(File.new(PLAY_VIEW, "r").read).result(binding)
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
