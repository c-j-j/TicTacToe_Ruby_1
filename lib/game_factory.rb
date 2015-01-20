require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'human_player.rb'

module TTT
  class GameFactory
    def initialize(display)
      @display = display
    end

    def build_hvh_game
      board = TTT::Board.new
      player_1 = TTT::HumanPlayer.new(@display, board, 'X')
      player_2 = TTT::HumanPlayer.new(@display, board, 'O')
      game = TTT::Game.new(board, @display, player_1, player_2)
    end
  end
end
