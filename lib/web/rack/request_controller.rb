require 'rack'
require 'lib/web/rack/index_controller'
require 'lib/web/rack/newgame_controller'
require 'lib/web/rack/play_turn_controller'
require 'lib/web/rack/web_interface'

module TTT
  module Web
    class RequestController

      def router
        Rack::Builder.new do
          map '/' do
            run TTT::Web::IndexController.new
          end

          map '/new_game' do
            run TTT::Web::NewGameController.new(TTT::Web::WebInterface.new)
          end

          map '/play_move' do
            run TTT::Web::PlayTurnController.new
          end
        end
      end
    end
  end
end
#module TTT
#module Web
#class RequestController
#INDEX_VIEW = File.dirname(__FILE__) + '/views/index.html.erb'
#PLAY_VIEW = File.dirname(__FILE__) + '/views/play.html.erb'

#def initialize(erb_file_parser)
#@erb_file_parser = erb_file_parser
#end

#def call(env)
#req = Rack::Request.new(env)
#puts req.params
#req.session[:game] = TTT::Game.build_game(nil, TTT::Game::GAME_TYPES[0], 3)

#game = req.session[:game]
#puts game
#puts game.player_1.mark
#puts game.player_2.mark
#puts game.board
##i can do req.params['game_type'] to get game type
##puts env
##puts env
#[ 200, {'Content-Type' => 'text/html'}, [get_response(env)] ]
#end

#def get_response(env)
#path = env["PATH_INFO"]

#if path.include?('play')
## game is played
## board is retreived and set as instance variable
## instance varaibles
## template parsed
## some kind of gameplay controller here
#@erb_file_parser.parse(PLAY_VIEW)
#else
#variables = {game_types: TTT::Game::GAME_TYPES, board_sizes: TTT::Game::BOARD_SIZES}
#@erb_file_parser.parse(INDEX_VIEW, variables)
#end
#end
#end
#end
#end
