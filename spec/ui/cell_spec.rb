require_relative '../spec_helper.rb'
require 'lib/ui/qt_cell'

describe TTT::UI::QTCell do

  let(:cell_number){ 1 }
  let(:parent) {double('parent')}
  let(:cell) { TTT::UI::QTCell.new(parent, cell_number)}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'it notifies parent of mouse click' do
    expect(parent).to receive(:board_clicked).with(cell_number)
    cell.mousePressEvent(nil)
  end

end
