require 'spec_helper'
require 'game'
require 'spec/stubs/stub_interface.rb'

describe "Integration Tests" do
  let(:user_interface) { TTT::StubInterface.new }

  it 'runs through cvc game and ends in draw with 3x3 board' do
    cvc_game = TTT::Game.build_game(user_interface, TTT::Game::CVC, 3)
    until cvc_game.game_over?
      cvc_game.play_turn
    end
    expect(cvc_game.model_data.status).to be(TTT::Game::DRAW)
  end

  xit 'runs through cvc game and ends in draw with 4x4 board' do
    cvc_game = TTT::Game.build_game(user_interface, TTT::Game::CVC, 4)
    until cvc_game.game_over?
      cvc_game.play_turn
    end
    expect(cvc_game.model_data.status).to be(TTT::Game::DRAW)
  end

end
