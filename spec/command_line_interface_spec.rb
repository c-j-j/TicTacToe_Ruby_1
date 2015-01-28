require_relative '../lib/command_line_interface.rb'
require_relative 'helpers/board_helper.rb'
require_relative 'stubs/stub_player.rb'
require_relative '../lib/board.rb'

describe TTT::CommandLineInterface do

  FAKE_USER_INPUT = "some user input"

  let(:board) { TTT::Board.new }
  let(:board_helper) { TTT::BoardHelper.new(board) }
  let(:stub_player_1) { TTT::StubPlayer.new('X') }
  let(:stub_player_2) { TTT::StubPlayer.new('O') }
  let(:output) { StringIO.new }
  let(:input) { StringIO.new("#{FAKE_USER_INPUT}\n") }
  let(:display) { TTT::CommandLineInterface.new(input, output) }

  it 'prints full board' do
    p1_mark = 'X'
    p2_mark = 'O'
    board_helper.add_moves_to_board([0, 1, 2, 6, 7, 8], p1_mark)
    board_helper.add_moves_to_board([3, 4, 5], p2_mark)

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

  it 'grabs and chomps user input' do
    expect(display.get_user_input).to eq(FAKE_USER_INPUT)
  end

  it 'grabs the next move and decrements by 1' do
    display = TTT::CommandLineInterface.new(user_input('1'), output)
    expect(display.get_user_move(board)).to eq(0)
  end

  it 'performs validation against non-integer inputted' do
    display = TTT::CommandLineInterface.new(user_input('A','1'), output)
    display.get_user_move(board)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'performs validation against board' do
    board_helper.add_moves_to_board([0], 'X')
    display = TTT::CommandLineInterface.new(user_input('1','2'), output)
    display.get_user_move(board)
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  def user_input(*input)
   input_string = ''
   input.each do |element|
    input_string << element << "\n"
   end
   StringIO.new(input_string)
  end

  it 'prints invalid message' do
    display.print_invalid_message
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end

  it 'displays prompt to pick game type' do
    display = TTT::CommandLineInterface.new(user_input('0'), output)
    game_type_description = 'SomeGameDescription'
    display.get_game_type({
      '0' => game_type_description
    })
    expect(output.string).to include(TTT::CommandLineInterface::PICK_GAME_TYPE)
    expect(output.string).to include(game_type_description)

  end

  it 'gets user input to pick game' do
    game_choices = {
      '0' => 'Human Vs Human'
    }
    display = TTT::CommandLineInterface.new(user_input('0'), output)

    expect(display.get_game_type(game_choices)).to eq('0')
  end

  it 'validates user input with choices provided' do
    game_choices = {
      '0' => 'Human Vs Human'
    }
    display = TTT::CommandLineInterface.new(user_input('1', '0'), output)

    expect(display.get_game_type(game_choices)).to eq('0')
    expect(output.string).to include(TTT::CommandLineInterface::INVALID_MOVE_MESSAGE)
  end
end
