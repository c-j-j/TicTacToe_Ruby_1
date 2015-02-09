require 'spec_helper'
require 'spec/stubs/stub_game'
require 'web/rack/newgame_controller'
require 'spec/stubs/stub_interface'
require 'rack/test'

describe TTT::Web::NewGameController do
  include Rack::Test::Methods
  let(:game) { TTT::StubGame.new }
  let(:new_game_controller) { TTT::Web::NewGameController.new}

  let(:env) {{
    'REQUEST_METHOD' => 'GET',
    'QUERY_STRING'  => 'game_type=Human+Vs+Human&board_size=3',
    'rack.input' => ''
  }}

  def app
    new_game_controller
  end

  it 'stores new game in the session' do
    env = {}
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'}, env)
    expect(retrieve_game_from_session).not_to be_nil
  end

  it 'builds a 3x3 board' do
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'}, env)
    expect(retrieve_game_from_session.row_size).to eq(3)
  end

  it 'redirects to play turn controller' do
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'}, env)
    expect(last_response.status).to eq(302)
  end

  def retrieve_game_from_session
    last_request.env['rack.session'][:game]
  end
end
