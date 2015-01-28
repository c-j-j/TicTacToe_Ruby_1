require_relative '../lib/board.rb'
require_relative 'helpers/board_helper.rb'

describe TTT::Board do

  let(:mark){'X'}
  let(:board_3x3) { TTT::Board.new(3) }
  let(:board_4x4) { TTT::Board.new(4) }
  let(:board_helper) { TTT::BoardHelper.new }

  it 'marks board with player move 0' do
    player_move = 0
    board_3x3.add_move(mark, player_move)
    expect(board_3x3.positions[player_move]).to be(mark)
  end

  it 'game not over when board is empty' do
    expect(board_3x3.game_over?).to be false
  end

  it 'game not over when single mark on board' do
    board_3x3.add_move(mark, 0)
    expect(board_3x3.game_over?).to be false
  end

  it 'board not won when board is empty' do
    expect(board_3x3.won?).to be false
  end

  it 'board has been won when mark exists on winning line' do
    board_helper.add_moves_to_board(board_3x3, [0, 1, 2], mark)
    expect(board_3x3.won?).to be true
  end

  it 'board aware game is over when winner exists' do
    board_helper.add_moves_to_board(board_3x3, [0, 1, 2], mark)
    expect(board_3x3.game_over?).to be true
  end

  it 'game is not a tie when board is empty' do
    expect(board_3x3.draw?).to be false
  end

  it 'game is a tie when 3x3 board is full and no winner' do
    board_helper.add_moves_to_board(board_3x3, [0, 1, 5, 6, 8], mark)
    board_helper.add_moves_to_board(board_3x3, [2, 3, 4, 7], 'opponent mark')
    expect(board_3x3.draw?).to be true
  end

  it 'game is a not a tie when 3x3 board is full and winner exists' do
    board_helper.add_moves_to_board(board_3x3, [0, 1, 2, 3, 4, 5, 6, 7, 8], mark)
    expect(board_3x3.draw?).to be false
  end

  it 'board aware of game over due to draw' do
    board_helper.add_moves_to_board(board_3x3, [0, 1, 5, 6, 8], mark)
    board_helper.add_moves_to_board(board_3x3, [2, 3, 4, 7], 'opponent mark')
    expect(board_3x3.game_over?).to be true
  end

  it 'board has no winner on empty board' do
    expect(board_3x3.winner).to be nil
  end

  it '3x3 board has winner if top row is occupied by player' do
    test_mark_on_winning_line(board_3x3, [0, 1, 2])
  end

  it '3x3 board has winner if middle row is occupied by player' do
    test_mark_on_winning_line(board_3x3, [3, 4, 5])
  end

  it '3x3 board has winner if bottom row is occupied by player' do
    test_mark_on_winning_line(board_3x3, [6, 7, 8])
  end

  it '3x3 board has winner if left column is occupied by player' do
    test_mark_on_winning_line(board_3x3, [0, 3, 6])
  end

  it '3x3 board has winner if middle column is occupied by player' do
    test_mark_on_winning_line(board_3x3, [1, 4, 7])
  end

  it '3x3 board has winner if right column is occupied by player' do
    test_mark_on_winning_line(board_3x3, [2, 5, 8])
  end

  it '3x3 board has winner if diagonal line starting at top left is occupied by player' do
    test_mark_on_winning_line(board_3x3, [0, 4, 8])
  end

  it '3x3 board has winner if diagonal line starting at top right is occupied by player' do
    test_mark_on_winning_line(board_3x3, [2, 4, 6])
  end

  it '4x4 board has winner if top line occupied by player' do
    test_mark_on_winning_line(board_4x4, [0, 1, 2, 3])
  end

  it '4x4 board has winner if left column occupied by player' do
    test_mark_on_winning_line(board_4x4, [0, 4, 8, 12])
  end

  it '4x4 board has winner if diagonal line starting at top left is occupied by player' do
    test_mark_on_winning_line(board_4x4, [0, 5, 10, 15])
  end

  it '4x4 board has winner if diagonal line starting at top right is occupied by player' do
    test_mark_on_winning_line(board_4x4, [3, 6, 9, 12])
  end

  it 'board invalidates move is below lower bounds' do
    expect(board_3x3.is_move_valid?(-1)).to be false
  end
  it 'board invalidates move is below lower bounds' do
    expect(board_3x3.is_move_valid?(-1)).to be false
  end

  it 'board invalidates move if move is exceeds upper bounds' do
    expect(board_3x3.is_move_valid?(9)).to be false
  end

  it 'board validates move if move is within lower bounds' do
    expect(board_3x3.is_move_valid?(0)).to be true
  end

  it 'board validates move if move is within upper bounds' do
    expect(board_3x3.is_move_valid?(8)).to be true
  end

  it 'board invalidates move if position occupied already' do
    board_helper.add_moves_to_board(board_3x3, [0], mark)
    expect(board_3x3.is_move_valid?(0)).to be false
  end

  it 'board filters empty positions' do
    board_helper.add_moves_to_board(board_3x3, [0], mark)
    expect(board_3x3.empty_positions.size).to eq(board_3x3.positions.size - 1)
    expect(board_3x3.empty_positions).to_not include(0)
  end

  it 'board can be created from other board' do
    board_helper.add_moves_to_board(board_3x3, [0], mark)
    board_3x3_duplicate = board_3x3.copy
    expect(board_3x3_duplicate).to eq(board_3x3)
    board_3x3_duplicate.add_move(mark,1)
    expect(board_3x3.positions[1]).to_not eq(mark)
  end

  def test_mark_on_winning_line(board, moves)
    board_helper.add_moves_to_board(board, moves, mark)
    expect(board.winner).to eq mark
  end

end
