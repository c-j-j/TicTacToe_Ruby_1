require 'spec_helper'
require 'game'
require 'board'
require 'spec/stubs/stub_interface'
require 'spec/stubs/stub_player'
require 'spec/helpers/board_helper'

describe TTT::Game do
  let(:board) { TTT::Board.new(3) }
  let(:board_helper) { TTT::BoardHelper.new }
  let(:stub_interface) { TTT::StubInterface.new }
  let(:stub_player_1) { TTT::StubPlayer.new('X') }
  let(:stub_player_2) { TTT::StubPlayer.new('O') }
  let(:game) { TTT::Game.new(board, stub_interface, stub_player_1, stub_player_2) }

  it 'displays next player to move during a turn' do
    game.get_next_move
    expect(stub_interface.next_player_printed?).to be true
  end

  it 'displays board' do
    game.print_board
    expect(stub_interface.board_printed?).to be true
  end

  it 'gets next move from player' do
    game.get_next_move
    expect(stub_player_1.next_move_count).to be(1)
  end

  it 'adds move to board' do
    game.add_move_to_board(0)
    expect(board.get_mark_at_position(0)).to eq(stub_player_1.mark)
  end

  it 'current player initally set to player 1' do
    board_helper.populate_board_with_tie(board, stub_player_1, stub_player_2)
    game.play
    expect(game.current_player).to eq(stub_player_1)
  end

  it 'current player is swapped to player 2 when player 1 is current player' do
    game.swap_current_player
    expect(game.current_player).to eq(stub_player_2)
  end

  it 'current player is swapped to player 1 when current player is player 2' do
    game.swap_current_player
    game.swap_current_player
    expect(game.current_player).to eq(stub_player_1)
  end

  it 'plays next turn when play is triggered' do
    board_helper.add_moves_to_board(board, [0, 1], stub_player_1.mark)
    stub_player_1.prepare_next_move(2)
    game.play
    expect(stub_player_1.next_move_count).to eq(1)
  end

  it 'prints tie after game ends in tie' do
    board_helper.populate_board_with_tie(board, stub_player_1, stub_player_2)
    game.play
    expect(stub_interface.tie_message_printed?).to be true
  end

  it 'prints winner after game ends in win' do
    board_helper.populate_board_with_win(board, stub_player_1)
    game.play
    expect(stub_interface.winner_message_printed?).to be true
  end

  it 'prints board after game has ended' do
    board_helper.populate_board_with_win(board, stub_player_1)
    game.play
    expect(stub_interface.board_printed?).to be true
  end

  it 'gets row size from board' do
    expect(game.row_size).to eq(board.rows.size)
  end

  it 'gets number of positions from board' do
    expect(game.number_of_positions).to eq(board.number_of_positions)
  end

  it 'checks with board if move is valid' do
    expect(game.move_valid?(-1)).to eq(board.is_move_valid?(-1))
  end

  it 'adds move to board when new turn is played' do
    board_helper.add_moves_to_board(board, [0, 1], stub_player_1.mark)
    player_move = 2
    game.continue_game_with_move(player_move)
    expect(board.get_mark_at_position(player_move)).to eq(stub_player_1.mark)
  end

  it 'swaps player when new turn is played' do
    board_helper.add_moves_to_board(board, [0, 1], stub_player_1.mark)
    first_player = game.current_player
    game.continue_game_with_move(2)
    expect(game.current_player).to_not eq(first_player)
  end

  it 'displays winner when continued game turns into a win' do
    board_helper.add_moves_to_board(board, [0, 1], stub_player_1.mark)
    game.continue_game_with_move(2)
    expect(stub_interface.winner_message_printed?).to be true
  end

  it 'breaks out of game loop when next move yields no immediate response' do
    stub_player_1.prepare_next_move(TTT::Game::MOVE_NOT_AVAILABLE)
    game.play
    expect(stub_interface.winner_message_printed?).to be false
    expect(stub_interface.tie_message_printed?).to be false
  end

  it 'builds hvh game' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::HVH, 3)
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds hvc game' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::HVC, 3)
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds cvh game based on user input' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::CVH, 3)
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds cvc game based on user input' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::CVC, 3)
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_1.mark).to eq(TTT::Game::X)
    expect(game.player_2.mark).to eq(TTT::Game::O)
  end

  it 'builds game with board size of 4' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::CVH, 4)
  end

  it 'default board size is 3' do
    expect(TTT::Game.default_board_size).to eq(3)
  end

  it 'default game type is HVH' do
    expect(TTT::Game.default_game_type).to eq(TTT::Game::HVH)
  end


  it 'includes board in game information' do
    game.play_turn(0)
    game_info = game.information
    expect(game_info.board).to be(board)
  end

  it 'includes row size in game information' do
    game_info = game.information
    expect(game_info.row_size).to eq(3)
  end

  it 'status set to InProgress when no winner' do
    game.play_turn(0)
    game_info = game.information
    expect(game_info.status).to eq(TTT::Game::IN_PROGRESS)
  end

  it 'status set to win when game has been won' do
    board_helper.populate_board_with_win(board, stub_player_1.mark)
    game.play_turn(2)
    game_info = game.information
    expect(game_info.status).to eq(TTT::Game::WON)
  end

  it 'status set to winner when game has been won' do
    board_helper.populate_board_with_win(board, stub_player_1.mark)
    game.play_turn(2)
    game_info = game.information
    expect(game_info.winner).to eq(stub_player_1.mark)
  end

  it 'status set to draw when game is a draw' do
    board_helper.populate_board_with_tie(board, stub_player_1, stub_player_2)
    game.play_turn(2)
    game_info = game.information
    expect(game_info.status).to eq(TTT::Game::DRAW)
  end

  it 'swaps player when move is added to board' do
    game.play_turn(2)
    game_info = game.information
    expect(game_info.current_player_mark).to eq(stub_player_2.mark)
  end

  it 'does not swap player when move is not available from player' do
    game.play_turn(TTT::Game::MOVE_NOT_AVAILABLE)
    game_info = game.information
    expect(game_info.current_player_mark).to eq(stub_player_1.mark)
  end

  it 'asks next player for move if no move passed in' do
    stub_player_1.prepare_next_move(2)
    game.play_turn
    game_info = game.information
    expect(game_info.board.get_mark_at_position(2)).to eq(stub_player_1.mark)
  end

  it 'response says if current player is a ComputerPlayer' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::CVC, 4)
    game.play_turn(2)
    game_info = game.information
    expect(game_info.current_player_is_computer).to eq(true)
  end

  it 'response says if current player is not a ComputerPlayer' do
    game = TTT::Game.build_game(stub_interface, TTT::Game::HVH, 4)
    game.play_turn(2)
    game_info = game.information
    expect(game_info.current_player_is_computer).to eq(false)
  end
end
