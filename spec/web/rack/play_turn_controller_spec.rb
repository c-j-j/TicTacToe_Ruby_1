require 'spec_helper'
require 'web/rack/play_turn_controller'
require 'rack/test'
require 'spec/stubs/stub_game'

describe TTT::Web::PlayTurnController do
  include Rack::Test::Methods

  let(:controller) { TTT::Web::PlayTurnController.new }
  let(:game) { TTT::StubGame.new }
  let(:env) {
    { 'rack.session' => { :game => game },
      'params' => {'position' => '0' },
      'rack.input' => '',
      'PATH_INFO'=> '/play?a=b'
  }
  }

  def app
    controller
  end

  it 'creates game if it doesnt exist' do
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'})
    #TODO test
  end

  it 'sets div size to 24% when 4x4 board is set' do
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '4'})
    expect(controller.cell_size).to eq('24%')
  end

  it 'sets cell size to 32% when 3x3 board is used' do
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'})
    expect(controller.cell_size).to eq('32%')
  end

  it 'sets refresh_page when current player is the Computer' do
    game.play_turn_response({:current_player_is_computer => true, :status => TTT::Game::IN_PROGRESS})
    get('/',{'position' => '0'}, env)
    expect(controller.refresh_page).to eq(true)
  end

  it 'does not set refresh page when game has been won' do
    game.play_turn_response({:current_player_is_computer => false,
    :status => TTT::Game::WON})
    get('/',{'position' => '0'}, env)
    expect(controller.refresh_page).to eq(false)
  end

  it 'does not set refresh page when game has been won' do
    game.play_turn_response({:current_player_is_computer => false,
    :status => TTT::Game::DRAW})
    get('/',{'position' => '0'}, env)
    expect(controller.refresh_page).to eq(false)
  end
end
