require_relative '../lib/board.rb'

describe TTT::Board do

  let(:mark){'X'}
  let(:board) { TTT::Board.new }

  it 'marks board with player move 0' do
    player_move = 0
    board.add_move(mark, player_move)
    expect(board.positions[player_move]).to be(mark)
  end

  it 'game not over when board is empty' do
    expect(board.game_over?).to be false
  end

  it 'game not over when single mark on board' do
    board.add_move(mark, 0)
    expect(board.game_over?).to be false
  end

  it 'board not won when board is empty' do
    expect(board.won?).to be false
  end

  it 'board has been won when mark exists on winning line' do
    add_moves_to_board(mark, 0, 1, 2)
    expect(board.won?).to be true
  end

  it 'board aware game is over when winner exists' do
    add_moves_to_board(mark, 0, 1, 2)
    expect(board.game_over?).to be true
  end

  it 'game is not a tie when board is empty' do
    expect(board.draw?).to be false
  end

  it 'game is a tie when board is full and no winner' do
    add_moves_to_board(mark, 0, 1, 5, 6, 8)
    add_moves_to_board("some other player", 2, 3, 4, 7)
    expect(board.draw?).to be true
  end

  it 'game is a not a tie when board is full and winner exists' do
    add_moves_to_board(mark, 0, 1, 2, 3, 4, 5, 6, 7, 8)
    expect(board.draw?).to be false
  end

  it 'board aware of game over due to draw' do
    add_moves_to_board(mark, 0, 1, 5, 6, 8)
    add_moves_to_board("some other player", 2, 3, 4, 7)
    expect(board.game_over?).to be true
  end

  it 'board has no winner on empty board' do
    expect(board.winner).to be nil
  end

  it 'board has winner if top row is occupied by player' do
    add_moves_to_board(mark, 0 , 1 , 2)
    expect(board.winner).to be mark
  end

  it 'board has winner if middle row is occupied by player' do
    add_moves_to_board(mark, 3, 4, 5)
    expect(board.winner).to be mark
  end

  it 'board has winner if bottom row is occupied by player' do
    add_moves_to_board(mark, 6, 7, 8)
    expect(board.winner).to be mark
  end

  it 'board has winner if left column is occupied by player' do
    add_moves_to_board(mark, 0, 3, 6)
    expect(board.winner).to be mark
  end

  it 'board has winner if middle column is occupied by player' do
    add_moves_to_board(mark, 1, 4, 7)
    expect(board.winner).to be mark
  end

  it 'board has winner if right column is occupied by player' do
    add_moves_to_board(mark, 2, 5, 8)
    expect(board.winner).to be mark
  end

  it 'board has winner if diagonal line starting at top left is occupied by player' do
    add_moves_to_board(mark, 0, 4, 8)
    expect(board.winner).to be mark
  end

  it 'board has winner if diagonal line starting at top right is occupied by player' do
    add_moves_to_board(mark, 2, 4, 6)
    expect(board.winner).to be mark
  end

  it 'board invalidates move is below lower bounds' do
    expect(board.is_move_valid?(-1)).to be false
  end

  it 'board invalidates move if move is exceeds upper bounds' do
    expect(board.is_move_valid?(9)).to be false
  end

  it 'board validates move if move is within lower bounds' do
    expect(board.is_move_valid?(0)).to be true
  end

  it 'board validates move if move is within upper bounds' do
    expect(board.is_move_valid?(8)).to be true
  end

  it 'board invalidates move if position occupied already' do
    add_moves_to_board(mark, 0)
    expect(board.is_move_valid?(0)).to be false
  end

  it 'board filters empty positions' do
    add_moves_to_board(mark, 0)
    expect(board.empty_positions.size).to eq(board.positions.size - 1)
    expect(board.empty_positions).to_not include(0)
  end

  it 'board can be created from other board' do
    add_moves_to_board(mark, 0)
    board_duplicate = board.copy
    expect(board_duplicate).to eq(board)
    board_duplicate.add_move(mark,1)
    expect(board.positions[1]).to_not eq(mark)
  end

  def add_moves_to_board(player, *moves)
    moves.each do |move|
      board.add_move(player, move)
    end
  end
end
