require 'spec_helper'
require 'lib/ui/gui_board_cell'

describe TTT::UI::GUIBoardCell do

  let(:cell_number){ 1 }
  let(:parent) {double('parent')}
  let(:cell) { TTT::UI::GUIBoardCell.new(parent, cell_number)}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'it notifies parent of mouse click' do
    expect(parent).to receive(:board_clicked).with(cell_number)
    cell.mousePressEvent(nil)
  end

end
