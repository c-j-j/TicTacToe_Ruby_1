require_relative '../lib/display.rb'
require_relative 'helpers/board_helper.rb'
require_relative 'stubs/stub_player.rb'
require_relative '../lib/board.rb'

describe TTT::Display do

  FAKE_USER_INPUT = "some user input"

  let(:board) { TTT::Board.new }
  let(:board_helper) { TTT::BoardHelper.new(board) }
  let(:stub_player_1) { TTT::StubPlayer.new('X') }
  let(:stub_player_2) { TTT::StubPlayer.new('O') }
  let(:output) { StringIO.new }
  let(:input) { StringIO.new("#{FAKE_USER_INPUT}\n") }
  let(:display) { TTT::Display.new(input, output) }

  it 'renders full board' do
    p1_mark = 'X'
    p2_mark = 'O'
    board_helper.add_moves_to_board([0, 1, 2, 6, 7, 8], p1_mark)
    board_helper.add_moves_to_board([3, 4, 5], p2_mark)

    display.render_board(board)

    rows = output.string.lines
    expect(rows[0]).to include("#{p1_mark}  #{p1_mark}  #{p1_mark} ")
    expect(rows[1]).to include("#{p2_mark}  #{p2_mark}  #{p2_mark} ")
    expect(rows[2]).to include("#{p1_mark}  #{p1_mark}  #{p1_mark} ")
  end

  it 'renders empty board with numbers' do
    display.render_board(board)

    rows = output.string.lines

    expect(rows[0]).to include("0  1  2")
    expect(rows[1]).to include("3  4  5")
    expect(rows[2]).to include("6  7  8")
  end

  it 'renders tie message' do
    display.print_tie_message
    expect(output.string).to include('Game is a tie.')
  end

  it 'renders winner message' do
    display.print_winner_message(stub_player_1)
    expect(output.string).to include("#{stub_player_1.mark} has won.")
  end

  it 'prints next player message' do
    display.print_next_player_to_go(stub_player_1)
    expect(output.string).to include("#{stub_player_1.mark}'s turn.")
  end

  it 'grabs and chomps user input' do
    expect(display.get_user_input).to eq(FAKE_USER_INPUT)
  end

  it 'prints invalid message' do
    display.print_invalid_message
    expect(output.string).to include(TTT::Display::INVALID_MOVE_MESSAGE)
  end

  it 'displays prompt to pick game type' do
    display.get_game_type
    expect(output.string).to include(TTT::Display::PICK_GAME_TYPE)
  end

  it 'gets user input to pick game' do
    expect(display.get_game_type).to eq(FAKE_USER_INPUT)
  end
end
