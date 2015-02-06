require 'spec_helper'
require 'web/rack/play_turn_controller'
require 'web/rack/web_interface'
require 'rack/test'

describe TTT::Web::PlayTurnController do
  include Rack::Test::Methods

  let(:env) {
    { 'rack.session' => { :game => 'game' },
      'params' => {'position' => '0' },
      'rack.input' => '',
      'PATH_INFO'=> '/play?a=b'
    }
  }
  let(:web_interface) { instance_double('TTT::Web::WebInterface') }
  let(:play_turn_controller) { TTT::Web::PlayTurnController.new(web_interface) }

  def app
    TTT::Web::PlayTurnController.new(web_interface)
  end

  it 'returns OK status code' do
    expect(web_interface).to receive(:submit_move).with(any_args)
      get('/')
      expect(last_response.ok?).to eq(true)
  end
  it 'calls web interface with stored game' do
    expect(web_interface).to receive(:submit_move).with('game', '0')
    env = { 'rack.session' => { :game => 'game' } }
    get('/', {'position' => '0' }, env)
  end
end
