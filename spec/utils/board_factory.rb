require_relative '../../lib/board.rb'
require_relative 'stub_player.rb'

module TTT
  class BoardFactory

    attr_accessor :board
    attr_accessor :player_1
    attr_accessor :player_2
    
    def initialize
      @board = TTT::Board.new
      @player_1 = TTT::StubPlayer.new
      @player_2 = TTT::StubPlayer.new
    end

    def set_player_1_moves(*moves)
      moves.each {|move| @board.add_move(@player_1, move) }
    end

    def set_player_2_moves(*moves)
      moves.each {|move| @board.add_move(@player_2, move) }
    end
  end
end
