require_relative '../lib/minimax.rb'

describe TTT::Minimax do

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
