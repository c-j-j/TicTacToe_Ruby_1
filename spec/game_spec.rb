require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require_relative 'stubs/stub_interface.rb'
require_relative 'stubs/stub_player.rb'
require_relative 'helpers/board_helper.rb'

describe TTT::Game do
  let(:board) { TTT::Board.new(3) }
  let(:board_helper) { TTT::BoardHelper.new }
  let(:stub_interface) { TTT::StubInterface.new }
  let(:stub_player_1) { TTT::StubPlayer.new('X') }
  let(:stub_player_2) { TTT::StubPlayer.new('O') }
  let(:game) { TTT::Game.new(board, stub_interface, stub_player_1, stub_player_2) }

  it 'displays next player to move during a turn' do
    game.play_next_turn
    expect(stub_interface.next_player_printed?).to be true
  end

  it 'displays board during a turn' do
    game.play_next_turn
    expect(stub_interface.board_printed?).to be true
  end

  it 'gets next move from player' do
    game.play_next_turn
    expect(stub_player_1.next_move_count).to be(1)
  end

  it 'adds move to board' do
    game.play_next_turn
    player_move = stub_player_1.next_move
    expect(board.positions[player_move]).to eq(stub_player_1.mark)
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

  it 'builds hvh game based on user input' do
    stub_interface.specify_game_type(:HVH)
    game = TTT::Game.build_game_for_user(stub_interface)
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
  end

  it 'builds hvc game based on user input' do
    stub_interface.specify_game_type(:HVC)
    game = TTT::Game.build_game_for_user(stub_interface)
    expect(game.player_1).to be_kind_of(TTT::HumanPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
  end

  it 'builds cvh game based on user input' do
    stub_interface.specify_game_type(:CVH)
    game = TTT::Game.build_game_for_user(stub_interface)
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::HumanPlayer)
  end

  it 'builds cvh game based on user input' do
    stub_interface.specify_game_type(:CVC)
    game = TTT::Game.build_game_for_user(stub_interface)
    expect(game.player_1).to be_kind_of(TTT::ComputerPlayer)
    expect(game.player_2).to be_kind_of(TTT::ComputerPlayer)
  end
end
