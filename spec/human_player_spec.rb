require '../lib/human_player.rb'

class Fake_CLI_Renderer

  def set_user_input(mocked_user_input)
    @user_input = mocked_user_input
  end

  def get_user_input
    @user_input
  end
end

describe TTT::HumanPlayer do
  it 'gets user input as next move' do
    renderer = Fake_CLI_Renderer.new
    player = TTT::HumanPlayer.new(renderer)

    fake_user_move = '5'
    renderer.set_user_input(fake_user_move)

    expect(player.next_move).to eq(fake_user_move.to_i)
  end
end
