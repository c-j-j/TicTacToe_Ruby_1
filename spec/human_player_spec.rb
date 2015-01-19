require_relative '../lib/human_player.rb'
require_relative '../lib/board.rb'
require_relative 'utils/fake_display.rb'

describe TTT::HumanPlayer do
  MARK = 'X'
  let(:renderer){TTT::FakeDisplay.new}
  let(:board){TTT::Board.new}
  let(:player){TTT::HumanPlayer.new(renderer, board, MARK)}

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

  it 'to_s is equal to mark' do
    expect(player.to_s).to eq(MARK)
  end

  it 'asks next player to move' do
    fake_user_move = '5'
    renderer.set_user_input(fake_user_move)
    player.next_move
    expect(renderer.get_previous_renders).to include(TTT::HumanPlayer::PLAYER_TURN_MESSAGE % MARK)
  end

  it 'asks for player to move again if invalid move given' do
    renderer.set_user_input('10', '0')
    player.next_move
    expect(renderer.get_previous_renders).to include(TTT::HumanPlayer::PLAYER_INVALID_MOVE_MESSAGE % MARK)
  end
end
