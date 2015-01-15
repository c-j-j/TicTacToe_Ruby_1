require_relative 'game.rb'
require_relative 'game_loop.rb'
require_relative 'board.rb'
require_relative 'human_player.rb'

module TTT
  class Main
    def initialize(renderer)
      board = TTT::Board.new
      player_1 = TTT::HumanPlayer.new(renderer, board, 'X')
      player_2 = TTT::HumanPlayer.new(renderer, board, 'O')
      game = TTT::Game.new(renderer, board, player_1, player_2)
      @game_loop = TTT::GameLoop.new(game)
    end

    def run
      @game_loop.run
    end
  end
end

