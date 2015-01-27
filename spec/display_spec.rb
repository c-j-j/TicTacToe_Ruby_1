require_relative '../lib/display.rb'
require_relative 'helpers/board_factory.rb'

describe TTT::Display do

  FAKE_USER_INPUT = "some user input"

  let(:board_factory) { TTT::BoardFactory.new }
  let(:output) { StringIO.new }
  let(:input) { StringIO.new("#{FAKE_USER_INPUT}\n") }
  let(:display) { TTT::Display.new(input, output) }

  it 'renders full board' do
    board_factory.set_player_1_moves(0, 1, 2, 6, 7, 8)
    board_factory.set_player_2_moves(3, 4, 5)

    display.render_board(board_factory.board)  

    p1_mark = board_factory.player_1.mark
    p2_mark = board_factory.player_2.mark

    rows = output.string.lines
    expect(rows[0]).to include("#{p1_mark}  #{p1_mark}  #{p1_mark} ")
    expect(rows[1]).to include("#{p2_mark}  #{p2_mark}  #{p2_mark} ")
    expect(rows[2]).to include("#{p1_mark}  #{p1_mark}  #{p1_mark} ")
  end

  it 'renders empty board with numbers' do
    display.render_board(board_factory.board)  

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
    p1 = board_factory.player_1
    display.print_winner_message(p1)
    expect(output.string).to include("#{p1.mark} has won.")
  end
 
  it 'prints next player message' do
    p1 = board_factory.player_1
    display.print_next_player_to_go(p1)
    expect(output.string).to include("#{p1.mark}'s turn.")
  end

  it 'grabs and chomps user input' do
    expect(display.get_user_input).to eq(FAKE_USER_INPUT)
  end

  it 'prints invalid message' do
    display.print_invalid_message
    expect(output.string).to include(TTT::Display::INVALID_MOVE_MESSAGE)
  end
end
