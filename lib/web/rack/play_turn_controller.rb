require 'rack'
require 'lib/async_interface'

module TTT
  module Web
    class PlayTurnController

      PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

      attr_reader :refresh_page
      attr_reader :cell_size

      def initialize
        @refresh_page = false
      end

      def call(env)
        req = Rack::Request.new(env)
        game = retrieve_game(req)
        game.play_turn(extract_position_from_param(req))
        @game_model_data = game.model_data

        determine_if_refresh_required
        determine_cell_size(@game_model_data)

        [200,
         {'Content-Type' => 'text/html'},
         [generate_response]]
      end

      private

      def determine_cell_size(game_model_data)
        if game_model_data.row_size == 4
          @cell_size = '24%'
        elsif game_model_data.row_size == 3
          @cell_size = '32%'
        end
      end

      def game_over?
        #todo this logic doesnt belong here
        @game_model_data[:status] == TTT::Game::WON || @game_model_data[:status] == TTT::Game::DRAW
      end

      def generate_response
        ERB.new(File.new(PLAY_VIEW, "r").read).result(binding)
      end

      def determine_if_refresh_required
        if @game_model_data[:current_player_is_computer] && !game_over?
          @refresh_page = true
        end
      end

      def retrieve_game(request)
        request.session[:game]
      end

      def extract_position_from_param(req)
        position = req.params['position']
        position.to_i unless position.nil?
      end
    end
  end
end
