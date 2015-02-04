require 'web/rack/request_controller.rb'

describe TTT::Web::Rack::RequestController do
  let(:file_parser) { instance_double('ERBFileParser') }
  let(:controller) { TTT::Web::Rack::RequestController.new(file_parser) }

  it 'returns play.html /play is requested' do
    expect(file_parser).to receive(:parse).with(TTT::Web::Rack::RequestController::PLAY_VIEW)
    response = controller.call({'PATH_INFO'=> '/play'})
  end

  it 'returns index.html when / is requested' do
    expect(file_parser).to receive(:parse).with(TTT::Web::Rack::RequestController::INDEX_VIEW)
    response = controller.call({'PATH_INFO'=> '/'})
  end
end
