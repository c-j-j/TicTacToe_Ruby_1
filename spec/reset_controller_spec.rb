require 'web/rack/reset_controller'
require 'rack/test'

describe TTT::Web::ResetController do
  include Rack::Test::Methods


  let(:controller) { TTT::Web::ResetController.new }
  it 'clears game from session' do
     get('/')
  end

  def app
    controller
  end



end
