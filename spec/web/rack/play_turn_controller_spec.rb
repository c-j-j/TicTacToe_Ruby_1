require 'spec_helper'
require 'web/rack/play_turn_controller'
require 'rack/test'
require 'spec/stubs/stub_game'
require 'ostruct'

describe TTT::Web::PlayTurnController do
  include Rack::Test::Methods
  include Rack::Utils

  let(:game_model_data) { OpenStruct.new }

  let(:controller) { TTT::Web::PlayTurnController.new }
  let(:game) { TTT::StubGame.new }
  let(:board_param) { game.board_positions.to_json}

  def app
    controller
  end

  it 'sets div size to 24% when 4x4 board is set' do
    game_model_data.row_size = 4
    controller.determine_cell_size(game_model_data)
    expect(controller.determine_cell_size(game_model_data)).to eq('24%')
  end

  it 'sets cell size to 32% when 3x3 board is used' do
    game_model_data.row_size = 3
    controller.determine_cell_size(game_model_data)
    expect(controller.determine_cell_size(game_model_data)).to eq('32%')
  end

  it 'sets refresh page when current player is computer' do
    game_model_data.current_player_is_computer = true
    game_model_data.status = TTT::Game::IN_PROGRESS
    expect(controller.refresh_required?(game_model_data)).to be(true)
  end

  it 'does not set refresh page when game has been won' do
    game_model_data.current_player_is_computer = false
    game_model_data.status = TTT::Game::WON
    expect(controller.refresh_required?(game_model_data)).to be(false)
  end

  it 'does not set refresh page when game has been drawn' do
    game_model_data.current_player_is_computer = false
    game_model_data.status = TTT::Game::DRAW
    expect(controller.refresh_required?(game_model_data)).to be(false)
  end

  it 'builds game from parameters' do
    get('/',{'board' => board_param, 'game_type' => TTT::Game::HVH })
    expect(controller.game_model_data.status).to eq(TTT::Game::IN_PROGRESS)
  end

  it 'assigns board_params' do
    get('/',{'board' => board_param, 'game_type' => TTT::Game::HVH })
    expect(controller.board_param).to eq(escape(board_param))
  end

  it 'assigns game type' do
    get('/',{'board' => board_param, 'game_type' => TTT::Game::HVH })
    expect(controller.game_type_param).to eq(escape(TTT::Game::HVH))
  end
end
