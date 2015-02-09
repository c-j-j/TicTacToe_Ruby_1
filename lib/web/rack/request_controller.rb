require 'rack'
require 'lib/web/rack/index_controller'
require 'lib/web/rack/newgame_controller'
require 'lib/web/rack/play_turn_controller'

module TTT
  module Web
    class RequestController

      def router
        Rack::Builder.new do
          map '/' do
            run TTT::Web::IndexController.new
          end

          map '/new_game' do
            run TTT::Web::NewGameController.new
          end

          map '/play_move' do
            run TTT::Web::PlayTurnController.new
          end
        end
      end
    end
  end
end
