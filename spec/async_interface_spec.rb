require 'spec_helper'
require 'async_interface'
require 'game'

describe TTT::AsyncInterface do
  it 'returns move not available when user move requested' do
    interface = TTT::AsyncInterface.new
    expect(interface.get_user_move(nil)).to eq(TTT::Game::MOVE_NOT_AVAILABLE)
  end
end
