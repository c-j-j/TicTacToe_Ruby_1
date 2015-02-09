require 'spec_helper'
require 'lib/ui/gui_interface'
require 'lib/board'
require 'spec/stubs/stub_game'
require 'spec/helpers/board_helper'
require 'ostruct'

describe TTT::UI::GUIInterface do

  let(:board) { TTT::Board.new(3) }
  let(:board_helper) { TTT::BoardHelper.new }
  let(:position) {1}
  let(:stub_game){TTT::StubGame.new}
  let(:gui_interface){TTT::UI::GUIInterface.new(stub_game)}

  before(:all) do
    @app = Qt::Application.new(ARGV)
  end

  it 'creates board with cells' do
    gui_interface.init_board
    expect(gui_interface.cells.size).to be(stub_game.number_of_positions)
  end

  it 'deletes previous board when board is subsequently initiated' do
    gui_interface.init_board
    widget_count_after_first_initiation = gui_interface.ui_grid.count
    gui_interface.init_board
    widget_count_after_second_initiation = gui_interface.ui_grid.count

    expect(widget_count_after_first_initiation).to eq(widget_count_after_second_initiation)
  end

  it 'game state set to an initial state before game has begun' do
    expect(gui_interface.game_state).to eq(:INITIAL)
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
    gui_interface.init_board
    board = generate_board
    gui_interface.print_board(board)
    gui_interface.cells.each_with_index do |cell, index|
      expect(cell.text).to eq(board.get_mark_at_position(index))
    end
  end

  it 'sets game state to waiting when user move is requested' do
    gui_interface.get_user_move(nil)
    expect(gui_interface.game_state).to eq(:AWAITING_USER_MOVE)
  end

  it 'does not return move from user as it isnt available' do
    expect(gui_interface.get_user_move(nil)).to eq(TTT::Game::MOVE_NOT_AVAILABLE)
  end

  it 'populates game choices selection menu from Game object' do
    expect(gui_interface.game_choices.count).to eq(TTT::Game::GAME_TYPES.size)
  end

  it 'default game to be created is first of Games types' do
    expect(gui_interface.next_game_type_to_build).to eq(TTT::Game.default_game_type)
  end

  it 'populates size choices selection menu from Game' do
    expect(gui_interface.game_sizes.count).to eq(TTT::Game::BOARD_SIZES.size)
  end

  it 'default board size is first option provided by Game' do
    expect(gui_interface.next_board_size_to_build).to eq(TTT::Game.default_board_size)
  end

  it 'prepares selected board size to be the next board size to build' do
    gui_interface.prepare_board_size('some board size')
    expect(gui_interface.next_board_size_to_build).to eq('some board size')
  end

  it 'prepared selected game type to be the next game type to build' do
    gui_interface.prepare_next_game_type_to_create('some game type')
    expect(gui_interface.next_game_type_to_build).to eq('some game type')
  end

  it 'creates game with selected properties' do
    game = gui_interface.create_new_game
    expect(game).to be_kind_of(TTT::Game)
    expect(game.row_size).to eq(gui_interface.next_board_size_to_build)
  end

  it 'calls play turn when game is not over' do
    stub_game.play_turn_ends_game
    game_model = OpenStruct.new(:board => board, :current_player_mark => 'X')
    stub_game.set_model_data(game_model)
    gui_interface.play_game(stub_game)
    expect(stub_game.play_turn_called?).to be(true)
  end

  def generate_board
    board = TTT::Board.new(3)
    board_helper = TTT::BoardHelper.new
    board_helper.populate_board_with_tie(board, 'X', 'O')
    board
  end

end
