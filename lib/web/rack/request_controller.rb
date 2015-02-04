require 'game'

module TTT
  module Web
    module Rack
      class RequestController

        INDEX_VIEW = 'views/index.html'
        PLAY_VIEW = 'views/play.html'

        def initialize(erb_file_parser)
          @erb_file_parser = erb_file_parser
        end

        def call(env)
          [ 200, {'Content-Type' => 'text/html'}, [get_response(env)] ]
        end

        def get_response(env)
          path = env["PATH_INFO"]

          if path.include?('play')
            # game is played
            # board is retreived and set as instance variable
            # instance varaibles
            # template parsed
            @erb_file_parser.parse(PLAY_VIEW)
          else
            variables = {game_types: TTT::Game::GAME_TYPES, board_sizes: TTT::Game::BOARD_SIZES}
            @erb_file_parser.parse(INDEX_VIEW, variables)
          end
        end
      end
    end
  end
end


