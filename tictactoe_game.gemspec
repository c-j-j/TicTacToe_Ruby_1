# coding: utf-8
lib = File.expand_path('lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'TTT/version'

Gem::Specification.new do |spec|
  spec.name          = "tictactoe_game"
  spec.version       = TTT::VERSION
  spec.authors       = ["c-j-j"]
  spec.email         = ["chrisjordan1987@gmail.com"]
  spec.summary       = "TicTacToe Game"
  spec.description   = "TicTacToe Game Description"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = ["lib/tictactoe_game.rb", "lib/human_player.rb", "lib/computer_player.rb", "lib/board.rb", "lib/game_model_data.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
