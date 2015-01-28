require_relative '../lib/human_player.rb'
require_relative '../lib/board.rb'
require_relative 'stubs/stub_interface.rb'

describe TTT::HumanPlayer do
  let(:interface){TTT::StubInterface.new}
  let(:board){TTT::Board.new(3)}
  let(:player){TTT::HumanPlayer.new(interface, board, 'X')}

  it 'gets user input as next move' do
    fake_user_move = 5
    interface.set_user_moves(fake_user_move)
    expect(player.next_move).to eq(fake_user_move)
  end

end
