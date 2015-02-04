require 'spec_helper'
require 'web/rack/request_controller.rb'
require 'web/rack/erb_file_parser'

describe TTT::Web::Rack::RequestController do
  let(:file_parser) { instance_double('TTT::Web::Rack::ERBFileParser') }
  let(:controller) { TTT::Web::Rack::RequestController.new(file_parser) }

  it 'returns play.html /play is requested' do
    expect(file_parser).to receive(:parse).with(TTT::Web::Rack::RequestController::PLAY_VIEW)
    controller.call({'PATH_INFO'=> '/play'})
  end

  it 'returns index.html when / is requested' do
    expect(file_parser).to receive(:parse).with(TTT::Web::Rack::RequestController::INDEX_VIEW, kind_of(Hash))
    controller.call({'PATH_INFO'=> '/'})
  end

  it 'returns game types in index.html' do
    expect(file_parser).to receive(:parse).with(
      kind_of(String),
      hash_including(:game_types => TTT::Game::GAME_TYPES))
    controller.call({'PATH_INFO'=> '/'})
  end

  it 'returns board sizes in index.html' do
    expect(file_parser).to receive(:parse).with(
      kind_of(String),
      hash_including(:board_sizes => TTT::Game::BOARD_SIZES))

    controller.call({'PATH_INFO'=> '/'})
  end
end
