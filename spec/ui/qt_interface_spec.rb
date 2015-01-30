require_relative '../spec_helper.rb'
require 'lib/ui/qt_interface'
require 'spec/stubs/stub_game'
#require_relative '../../lib/ui/qt_interface.rb'
#require_relative 'stubs/stub_game.rb'

describe TTT::QT_Interface do

  let(:stub_game){TTT::StubGame.new}
  let(:qt_interface){TTT::QT_Interface.new}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'checks whether game is over when play occurs' do
    qt_interface.register_game(stub_game)
    qt_interface.play

    expect(stub_game.game_over_called?).to be true
  end

  it 'registers move with game' do
    qt_interface.register_game(stub_game)
    qt_interface.register_move(1)

    expect(stub_game.move_registered?(1)).to be true
  end

  it 'creates cells during initialize' do
    expect(qt_interface.cells.size).to be(9)
  end
end
