require_relative '../spec_helper.rb'
require 'lib/ui/qt_interface'
require 'spec/stubs/stub_game'

describe TTT::UI::QT_Interface do

  let(:position) {1}
  let(:stub_game){TTT::StubGame.new}
  let(:qt_interface){TTT::UI::QT_Interface.new(stub_game)}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'creates cells during initialize' do
    expect(qt_interface.cells.size).to be(9)
  end

  it 'validates user move' do
    qt_interface.board_clicked(position)
    expect(stub_game.move_valid_called?).to be true
  end

  it 'propogates move to game' do
    qt_interface.board_clicked(position)
    expect(stub_game.play_turn_called?).to be true
  end

  it 'displays winner' do
    qt_interface.print_winner_message('some winner')
    expect(qt_interface.status_label.text).to include('some winner')
    expect(qt_interface.status_label.text).to include('won')
  end

  it 'displays draw' do
    qt_interface.print_tie_message
    expect(qt_interface.status_label.text).to include('Game ended in draw')
  end

end
