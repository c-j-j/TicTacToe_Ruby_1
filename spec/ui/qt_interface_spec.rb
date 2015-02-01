require_relative '../spec_helper.rb'
require 'lib/ui/qt_interface'
require 'lib/board'
require 'spec/stubs/stub_game'
require 'spec/helpers/board_helper'

describe TTT::UI::QT_Interface do

  let(:position) {1}
  let(:stub_game){TTT::StubGame.new}
  let(:qt_interface){TTT::UI::QT_Interface.new(stub_game)}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'creates cells during initialize' do
    expect(qt_interface.cells.size).to be(stub_game.board.positions.size)
  end

  it 'starts game when play button is pressed' do
    qt_interface.play_button.pressed
    expect(stub_game.play_called?).to be true
  end

  it 'validates user move' do
    qt_interface.board_clicked(position)
    expect(stub_game.move_valid_called?).to be true
  end

  it 'propogates move to game when game state set to awaiting move' do
    qt_interface.get_user_move(nil)
    qt_interface.board_clicked(position)
    expect(stub_game.play_turn_called?).to be true
  end

  it 'does not propogate move to game when game state not awaiting move' do
    qt_interface.board_clicked(position)
    expect(stub_game.play_turn_called?).to be false
  end

  it 'prints winner message' do
    qt_interface.print_winner_message('some winner')
    expect(qt_interface.status_label.text).to include('some winner has won')
  end

  it 'prints draw message' do
    qt_interface.print_tie_message
    expect(qt_interface.status_label.text).to include('Game ended in draw')
  end

  it 'prints next player to go' do
    qt_interface.print_next_player_to_go('some player')
    expect(qt_interface.status_label.text).to include("some player's turn")
  end

  it 'prints invalid move message' do
    stub_game.all_moves_are_invalid
    qt_interface.board_clicked(position)
    expect(qt_interface.status_label.text).to include("Invalid move")
  end

  it 'prints board to cells' do
    board = generate_board
    qt_interface.print_board(board)
    qt_interface.cells.each_with_index do |cell, index|
      expect(cell.text).to eq(board.positions[index])
    end
  end

  it 'sets game state to waiting when user move is requested' do
    qt_interface.get_user_move(nil)
    expect(qt_interface.game_state).to eq(:AWAITING_USER_MOVE)
  end

  def generate_board
    board = TTT::Board.new(3)
    board_helper = TTT::BoardHelper.new
    board_helper.populate_board_with_tie(board, 'X', 'O')
    board
  end

end
