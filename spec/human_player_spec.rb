require_relative '../lib/human_player.rb'
require_relative '../lib/board.rb'

class Fake_CLI_Renderer

  def set_user_input(*mocked_user_input)
    @user_input = mocked_user_input
  end

  def get_user_input
    @user_input.shift
  end
end

describe TTT::HumanPlayer do
  let(:renderer){Fake_CLI_Renderer.new}
  let(:board){TTT::Board.new}
  let(:player){TTT::HumanPlayer.new(renderer, board)}

  it 'gets user input as next move' do
    fake_user_move = '5'
    renderer.set_user_input(fake_user_move)

    expect(player.next_move).to eq(fake_user_move.to_i)
  end

  it 'invalidates user input if non-number provided' do
    fake_user_move = '5'
    renderer.set_user_input('A', fake_user_move) 
    expect(player.next_move).to eq(fake_user_move.to_i)
  end

  it 'invalidates user input if board position is occupied ' do
    first_user_move = '0'
    board.add_move('some player', first_user_move.to_i)
    second_user_move = '1'
    renderer.set_user_input(first_user_move, second_user_move)
    expect(player.next_move).to eq(second_user_move.to_i)
  end
end
