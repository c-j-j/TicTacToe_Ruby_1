#\ -w -p 8765
use Rack::Reloader, 0
use Rack::ContentLength

$:<< File.join(File.dirname(__FILE__), '..')

require 'lib/web/rack/request_controller'
require 'lib/web/rack/erb_file_parser'

use Rack::Session::Cookie
run TTT::Web::RequestController.new.router

