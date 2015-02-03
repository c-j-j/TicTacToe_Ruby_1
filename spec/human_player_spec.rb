require_relative 'spec_helper.rb'
require 'human_player'
require 'board'
require 'spec/stubs/stub_interface'

describe TTT::HumanPlayer do
  let(:interface){TTT::StubInterface.new}
  let(:board){TTT::Board.new(3)}
  let(:player){TTT::HumanPlayer.new(interface, 'X')}

  it 'gets user input as next move' do
    fake_user_move = 5
    interface.set_user_moves(fake_user_move)
    expect(player.next_move(board)).to eq(fake_user_move)
  end

end
