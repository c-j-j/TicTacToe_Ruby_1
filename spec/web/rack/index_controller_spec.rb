require 'spec_helper'
require 'game'
require 'web/rack/index_controller'

describe TTT::Web::IndexController do
  let(:index_controller) { TTT::Web::IndexController.new }
  it 'returns 200 status code' do
    response = index_controller.call({})
    expect(response[0]).to eq(200)
  end

  it 'returns content type as html' do
    response = index_controller.call({})
    expect(response[1]).to eq({'Content-Type' => 'text/html'})
  end

  it 'returns index html with game types' do
    response = index_controller.call({})
    html_response = response[2][0]
    TTT::Game::GAME_TYPES.each do |game_type|
      expect(html_response).to include(game_type)
    end
  end

  it 'returns index html with board sizes' do
    response = index_controller.call({})
    html_response = response[2][0]
    TTT::Game::BOARD_SIZES.each do |board_size|
      expect(html_response).to include(board_size.to_s)
    end
  end
end
