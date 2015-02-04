require 'spec_helper'
require 'lib/command_line_interface.rb'
require 'lib/board.rb'
require 'spec/helpers/board_helper.rb'
require 'spec/stubs/stub_player.rb'
require 'spec/stubs/stub_game.rb'

describe TTT::CommandLineInterface do

  let(:board) { TTT::Board.new(3) }
  let(:board_helper) { TTT::BoardHelper.new }
  let(:stub_game) {TTT::StubGame.new }
  let(:stub_player_1) { TTT::StubPlayer.new('X') }
  let(:stub_player_2) { TTT::StubPlayer.new('O') }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:display) { TTT::CommandLineInterface.new(input, output) }

  it 'prints full board' do
    p1_mark = 'X'
    p2_mark = 'O'
    board_helper.add_moves_to_board(board, [0, 1, 2, 6, 7, 8], p1_mark)
    board_helper.add_moves_to_board(board, [3, 4, 5], p2_mark)

    display.print_board(board)

    rows = output.string.lines
    expect(rows[0]).to include("#{p1_mark}  #{p1_mark}  #{p1_mark} ")
    expect(rows[1]).to include("#{p2_mark}  #{p2_mark}  #{p2_mark} ")
    expect(rows[2]).to include("#{p1_mark}  #{p1_mark}  #{p1_mark} ")
  end

  it 'prints empty board with numbers' do
    display.print_board(board)

    rows = output.string.lines

    expect(rows[0]).to include("1  2  3")
    expect(rows[1]).to include("4  5  6")
    expect(rows[2]).to include("7  8  9")
  end

  it 'prints tie message' do
    display.print_tie_message
    expect(output.string).to include('Game is a tie.')
  end

  it 'prints winner message' do
    display.print_winner_message('X')
    expect(output.string).to include("X has won.")
  end

  it 'prints next player message' do
    display.print_next_player_to_go('X')
    expect(output.string).to include("X's turn.")
  end

  it 'grabs the next move and decrements by 1' do
    input.string = '1'
    expect(display.get_user_move(board)).to eq(0)
  end

  it 'performs validation against non-integer inputted' do
    input.string = user_input('A', '1')
    display.get_user_move(board)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'performs validation against board' do
    board_helper.add_moves_to_board(board, [0], 'X')
    input.string = user_input('1', '2')
    display.get_user_move(board)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'prints invalid message' do
    display.print_invalid_message
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'displays prompt to pick game type' do
    input.string = user_input('1')
    game_type_description = 'SomeGameDescription'
    display.get_game_type({
      :GameType => game_type_description
    })
    expect(output.string).to include(TTT::CommandLineInterface::PICK_GAME_TYPE)
    expect(output.string).to include(game_type_description)

  end

  it 'user inputs integer to specify game type' do
    game_choices = [
      'Human Vs Human'
    ]
    input.string = user_input('1')
    expect(display.get_game_type(game_choices)).to eq('Human Vs Human')
  end

  it 'validates user input with choices provided' do
    game_choices = [
      'Human Vs Human'
    ]

    input.string = user_input('a', '0', '1')
    display.get_game_type(game_choices)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'prompts user to specify board size' do
    input.string = user_input('3')
    display.get_board_size(3)
    expect(output.string).to include(TTT::CommandLineInterface::PICK_BOARD_SIZE)
    expect(output.string).to include('3')
  end

  it 'gets user input for board size' do
    input.string = user_input('3')
    expect(display.get_board_size(3)).to eq(3)
  end

  it 'invalidates user input for board size if non-integer provided' do
    input.string = user_input('a', '3')
    expect(display.get_board_size(3, 4)).to eq(3)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'invalidates user input if board size provided not in list of options' do
    input.string = user_input('5', '4')
    expect(display.get_board_size(3, 4)).to eq(4)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'requests board size when prepare_game is called' do
    input.string = user_input('1', '3')
    display.prepare_game
    expect(output.string).to include(TTT::CommandLineInterface::PICK_BOARD_SIZE)
  end

  it 'displays board sizes retrieved from game object' do
    input.string = user_input('1', '3')
    display.prepare_game
    TTT::Game::BOARD_SIZES.each do |size|
      expect(output.string).to include(size.to_s)
    end
  end

  it 'requests game type when prepare_game is called' do
    input.string = user_input('1', '3')
    display.prepare_game
    expect(output.string).to include(TTT::CommandLineInterface::PICK_GAME_TYPE)
  end

  it 'displays game types retreived from game object' do
    input.string = user_input('1', '3')
    display.prepare_game
    TTT::Game::GAME_TYPES.each do |type|
      expect(output.string).to include(type)
    end
  end

  it 'builds game from input' do
    input.string = user_input('1','3')
    display.prepare_game
    expect(display.game).to be_kind_of(TTT::Game)
  end

  it 'plays game when user has pressed key' do
    display = TTT::CommandLineInterface.new(input, output, stub_game)
    display.show
    expect(stub_game.play_called?).to eq(true)
  end

  def user_input(*input)
    input_string = ''
    input.each do |element|
      input_string << element << "\n"
    end
    input_string
  end

end
