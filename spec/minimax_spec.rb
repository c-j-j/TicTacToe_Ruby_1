require_relative '../lib/minimax.rb'

module TTT
  class TestBoard
    attr_accessor :game_over_count
    def initialize
      @game_over_count = 0
      @game_over_sequence = []
    end

    def set_game_over_sequence(*sequence)
      @game_over_sequence = sequence
    end

    def game_over?
      @game_over_count += 1
      return @game_over_sequence.shift
    end
  end
end

describe TTT::Minimax do

  let(:board) {TTT::TestBoard.new}
  let(:minimax) { TTT::Minimax.new(board) }

  #it 'calls terminal state checker' do
    #score = minimax.minimax
    #expect(score).to be(0)
  #end

  #it 'return 0 when game is over immediately' do
    #board.set_game_over_sequence(true)
    #scores = minimax.minimax
    #expect(scores).to be(0)
    #expect(board.game_over_count).to be(1)
  #end

end
