require_relative '../lib/game.rb'
require_relative 'stubs/stub_interface.rb'

describe "Integration Tests" do
  let(:user_interface) { TTT::StubInterface.new }

  it 'run through hvh game where player X wins with 3x3 board' do
    user_interface.specify_board_size(3)
    user_interface.specify_game_type(TTT::Game::HVH)
    hvh_game = TTT::Game.build_game_by_calling_interface(user_interface)
    user_interface.set_user_moves(0, 1, 2, 3, 4, 5, 6, 7, 8)
    hvh_game.play
    expect(user_interface.winner_message_printed?).to be true
  end

  it 'run through hvh game where there is a tie with 3x3 board' do
    user_interface.specify_board_size(3)
    user_interface.specify_game_type(TTT::Game::HVH)
    hvh_game = TTT::Game.build_game_by_calling_interface(user_interface)
    user_interface.set_user_moves(0, 1, 2, 3, 5, 4, 7, 8, 6)
    hvh_game.play
    expect(user_interface.winner_message_printed?).to be false
    expect(user_interface.tie_message_printed?).to be true
  end

  it 'runs through cvc game and ends in draw with 3x3 board' do
    user_interface.specify_board_size(3)
    user_interface.specify_game_type(TTT::Game::CVC)
    cvc_game  = TTT::Game.build_game_by_calling_interface(user_interface)
    cvc_game.play
    expect(user_interface.winner_message_printed?).to be false
    expect(user_interface.tie_message_printed?).to be true
  end

  it 'runs through cvc game and ends in draw with 4x4 board' do
    user_interface.specify_board_size(4)
    user_interface.specify_game_type(TTT::Game::CVC)
    cvc_game  = TTT::Game.build_game_by_calling_interface(user_interface)
    cvc_game.play
    expect(user_interface.winner_message_printed?).to be false
    expect(user_interface.tie_message_printed?).to be true
  end

end
