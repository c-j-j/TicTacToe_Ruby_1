#\ -w -p 8765
use Rack::Reloader, 0
use Rack::ContentLength

$:<< File.join(File.dirname(__FILE__), '..')

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

require 'lib/web/rack/request_controller'

run TTT::Web::RequestController.new.router

