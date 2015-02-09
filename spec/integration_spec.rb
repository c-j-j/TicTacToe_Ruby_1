require 'spec_helper'
require 'tictactoe_game'
require 'spec/stubs/stub_interface.rb'

describe "Integration Tests" do
  let(:user_interface) { TTT::StubInterface.new }

  it 'run through hvh game where player X wins with 3x3 board' do
    hvh_game = TTT::Game.build_game(user_interface, TTT::Game::HVH, 3)
    user_interface.set_user_moves(0, 1, 2, 3, 4, 5, 6, 7, 8)
    hvh_game.play
    expect(user_interface.winner_message_printed?).to be true
  end

  it 'run through hvh game where there is a tie with 3x3 board' do
    hvh_game = TTT::Game.build_game(user_interface, TTT::Game::HVH, 3)
    user_interface.set_user_moves(0, 1, 2, 3, 5, 4, 7, 8, 6)
    hvh_game.play
    expect(user_interface.winner_message_printed?).to be false
    expect(user_interface.tie_message_printed?).to be true
  end

  it 'runs through cvc game and ends in draw with 3x3 board' do
    cvc_game = TTT::Game.build_game(user_interface, TTT::Game::CVC, 3)
    cvc_game.play
    expect(user_interface.winner_message_printed?).to be false
    expect(user_interface.tie_message_printed?).to be true
  end

  xit 'runs through cvc game and ends in draw with 4x4 board' do
    cvc_game = TTT::Game.build_game(user_interface, TTT::Game::CVC, 4)
    cvc_game.play
    expect(user_interface.winner_message_printed?).to be false
    expect(user_interface.tie_message_printed?).to be true
  end

end
