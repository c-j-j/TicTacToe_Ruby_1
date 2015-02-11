require 'spec_helper'
require 'spec/stubs/stub_game'
require 'web/rack/newgame_controller'
require 'spec/stubs/stub_interface'
require 'rack/test'

describe TTT::Web::NewGameController do
  include Rack::Test::Methods

  let(:game_type) { 'Human Vs Human' }
  let(:game) { TTT::StubGame.new }
  let(:new_game_controller) { TTT::Web::NewGameController.new}

  def app
    new_game_controller
  end

  it 'redirects to play turn controller' do
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'})
    follow_redirect!
    expect(last_request.url).to include('play_turn')
    expect(last_response.status).to eq(302)
  end

  it 'adds game type in redirect url' do
    get('/', {'game_type' => game_type, 'board_size' => '3'})
    follow_redirect!
    expect(last_request.params['game_type']).to eq(game_type)
  end

  it 'adds empty board to redirect url' do
    get('/', {'game_type' => game_type, 'board_size' => '3'})
    follow_redirect!
    JSON.parse(last_request.params['board']).each do |cell|
      expect(cell).to be(nil)
    end
  end
end
