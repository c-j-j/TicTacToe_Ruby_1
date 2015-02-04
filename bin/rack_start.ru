#\ -w -p 8765
use Rack::Reloader, 0
use Rack::ContentLength

$:<< File.join(File.dirname(__FILE__), '..')
require 'lib/web/rack/ttt_rack_server'

run RequestController.new
