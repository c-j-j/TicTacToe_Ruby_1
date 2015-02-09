require 'spec_helper'
require 'web/rack/play_turn_controller'
require 'rack/test'
require 'spec/stubs/stub_game'
require 'ostruct'

describe TTT::Web::PlayTurnController do
  let(:game_information) { OpenStruct.new }
  include Rack::Test::Methods

  let(:controller) { TTT::Web::PlayTurnController.new }
  let(:game) { TTT::StubGame.new }
  let(:env) {
    { 'rack.session' => { :game => game },
  }
  }

  def app
    controller
  end

  it 'sets div size to 24% when 4x4 board is set' do
    game_information.current_player_is_computer = true
    game_information.row_size = 4
    game.set_information(game_information)
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '4'}, env)
    expect(controller.cell_size).to eq('24%')
  end

  it 'sets cell size to 32% when 3x3 board is used' do
    game_information.current_player_is_computer = true
    game_information.row_size = 3
    game.set_information(game_information)
    get('/', {'game_type' => 'Human Vs Human', 'board_size' => '3'}, env)
    expect(controller.cell_size).to eq('32%')
  end

  it 'sets refresh_page when current player is the Computer' do
    game_information.status = TTT::Game::IN_PROGRESS
    game_information.current_player_is_computer = true
    game.set_information(game_information)

    get('/',{'position' => '0'}, env)
    expect(controller.refresh_page).to eq(true)
  end

  it 'does not set refresh page when game has been won' do
    game_information.status = TTT::Game::WON
    game.set_information(game_information)

    get('/',{'position' => '0'}, env)
    expect(controller.refresh_page).to eq(false)
  end

  it 'does not set refresh page when game has been drawn' do
    game_information.status = TTT::Game::DRAW
    game_information.current_player_is_computer = false
    game.set_information(game_information)

    get('/',{'position' => '0'}, env)
    expect(controller.refresh_page).to eq(false)
  end
end
