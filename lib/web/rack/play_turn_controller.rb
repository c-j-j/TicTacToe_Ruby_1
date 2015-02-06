require 'rack'

module TTT
  module Web
    class PlayTurnController

      def initialize(web_interface)
        @web_interface = web_interface
      end

      def call(env)
        req = Rack::Request.new(env)
        [200,
         {'Content-Type' => 'text/html'},
         [@web_interface.submit_move(extract_game_from_request(req), extract_position_from_param(req))]]
      end

      private

      def extract_game_from_request(req)
        req.session[:game]
      end

      def extract_position_from_param(req)
         req.params['position']
      end
    end
  end
end
