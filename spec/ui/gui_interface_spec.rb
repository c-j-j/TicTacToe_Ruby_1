require_relative '../spec_helper.rb'
require 'lib/ui/gui_interface'
require 'lib/board'
require 'spec/stubs/stub_game'
require 'spec/helpers/board_helper'

describe TTT::UI::GUIInterface do

  let(:position) {1}
  let(:stub_game){TTT::StubGame.new}
  let(:gui_interface){TTT::UI::GUIInterface.new(stub_game)}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'creates cells during initialize' do
    expect(gui_interface.cells.size).to be(stub_game.number_of_positions)
  end

  it 'game state set to an initial state before game has begun' do
    expect(gui_interface.game_state).to eq(:INITIAL)
  end

  it 'starts game when play button is pressed' do
    gui_interface.play_button.pressed
    expect(stub_game.play_called?).to be true
  end

  it 'validates user move when awaiting user move' do
    gui_interface.get_user_move(nil)
    gui_interface.board_clicked(position)
    expect(stub_game.move_valid_called?).to be true
  end

  it 'propogates move to game when game state set to awaiting move' do
    gui_interface.get_user_move(nil)
    gui_interface.board_clicked(position)
    expect(stub_game.continue_game_called?).to be true
  end

  it 'does not propogate move to game when game state not awaiting move' do
    gui_interface.board_clicked(position)
    expect(stub_game.continue_game_called?).to be false
  end

  it 'sets game state to in progress when user has made valid move' do
    gui_interface.get_user_move(nil)
    gui_interface.board_clicked(position)
    expect(gui_interface.game_state).to eq(:IN_PROGRESS)
  end

  it 'prints winner message' do
    gui_interface.print_winner_message('some winner')
    expect(gui_interface.status_label.text).to include('some winner has won')
  end

  it 'sets state to finish when winner message is printed' do
    gui_interface.print_winner_message('some winner')
    expect(gui_interface.game_state).to eq(:GAME_OVER)
  end

  it 'prints draw message' do
    gui_interface.print_tie_message
    expect(gui_interface.status_label.text).to include('Draw')
  end

  it 'sets state to finish when tie message is printed' do
    gui_interface.print_tie_message
    expect(gui_interface.game_state).to eq(:GAME_OVER)
  end

  it 'prints next player to go' do
    gui_interface.print_next_player_to_go('some player')
    expect(gui_interface.status_label.text).to include("some player's turn")
  end

  it 'prints invalid move message' do
    gui_interface.get_user_move(nil)
    stub_game.all_moves_are_invalid
    gui_interface.board_clicked(position)
    expect(gui_interface.status_label.text).to include("Invalid move")
  end

  it 'prints board to cells' do
    board = generate_board
    gui_interface.print_board(board)
    gui_interface.cells.each_with_index do |cell, index|
      expect(cell.text).to eq(board.positions[index])
    end
  end

  it 'sets game state to waiting when user move is requested' do
    gui_interface.get_user_move(nil)
    expect(gui_interface.game_state).to eq(:AWAITING_USER_MOVE)
  end

  it 'returns awaiting state when user move requested' do
    expect(gui_interface.get_user_move(nil)).to eq(:AWAITING_USER_MOVE)
  end

  def generate_board
    board = TTT::Board.new(3)
    board_helper = TTT::BoardHelper.new
    board_helper.populate_board_with_tie(board, 'X', 'O')
    board
  end

end
