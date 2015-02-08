require 'spec_helper'
require 'spec/stubs/stub_game'
require 'web/rack/newgame_controller'
require 'spec/stubs/stub_interface'

describe TTT::Web::NewGameController do
  let(:game) { TTT::StubGame.new }
  let(:web_interface) { TTT::StubInterface.new }
  let(:gameplay_controller) { TTT::Web::NewGameController.new(web_interface)}

  let(:env) {{
    'REQUEST_METHOD' => 'GET',
    'QUERY_STRING'  => 'game_type=Human+Vs+Human&board_size=3',
    'rack.input' => ''
  }}

  it 'stores new game as a cookie' do
    gameplay_controller.call(env)
    expect(env['rack.session'][:game]).not_to be_nil
  end

  it 'builds a 3x3 board' do
    gameplay_controller.call(env)
    game = env['rack.session'][:game]
    expect(game.row_size).to eq(3)
  end

end
