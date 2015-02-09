require 'lib/tictactoe_game'

module TTT
  module Web
    class IndexController

      INDEX_VIEW = File.dirname(__FILE__) + '/views/index.html.erb'

      def call(env)
        game_types = TTT::Game::GAME_TYPES
        board_sizes = TTT::Game::BOARD_SIZES
        response = ERB.new(File.new(INDEX_VIEW, "r").read).result(binding)
        [200, {'Content-Type' => 'text/html'}, [response]]
      end
    end
  end
end
