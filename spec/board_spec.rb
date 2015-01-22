require_relative '../lib/board.rb'

describe TTT::Board do
  let(:board) { TTT::Board.new }
  MARK = 'some_mark'

  it 'marks board with player move 0' do
    player_move = 0
    board.add_move(MARK, player_move)
    expect(board.positions[player_move]).to be(MARK)
  end

  it 'marks board with player move 8' do
    player_move = 8
    board.add_move(MARK, player_move)
    expect(board.positions[player_move]).to be(MARK)
  end

  it 'game not over when board is empty' do
    expect(board.game_over?).to be false
  end

  it 'game not over when single mark on board' do
    board.add_move(MARK, 0)
    expect(board.game_over?).to be false
  end

  it 'board returns false if game not won' do
    expect(board.has_been_won?).to be false
  end

  it 'board returns true if game has been won' do
    add_moves_to_board(MARK, 0, 1, 2)
    expect(board.has_been_won?).to be true
  end

  it 'board returns true if game over due to win' do
    add_moves_to_board(MARK, 0, 1, 2)
    expect(board.game_over?).to be true
  end

  it 'game is not a tie when board is empty' do
    expect(board.is_a_tie?).to be false
  end

  it 'game is a tie when board is full and no winner' do
    add_moves_to_board(MARK, 0, 1, 5, 6, 8)
    add_moves_to_board("some other player", 2, 3, 4, 7)
    expect(board.is_a_tie?).to be true 
  end

  it 'game is a not a tie when board is full and winner exists' do
    add_moves_to_board(MARK, 0, 1, 2, 3, 4, 5, 6, 7, 8)
    expect(board.is_a_tie?).to be false
  end

  it 'board returns true if game over due to draw' do
    add_moves_to_board(MARK, 0, 1, 5, 6, 8)
    add_moves_to_board("some other player", 2, 3, 4, 7)
    expect(board.game_over?).to be true
  end

  it 'board returns nil if no winner on board' do
    expect(board.winner).to be nil
  end

  it 'board returns winner if top row is occupied by player' do
    add_moves_to_board(MARK, 0 , 1 , 2)
    expect(board.winner).to be MARK
  end

  it 'board returns winner if middle row is occupied by player' do
    add_moves_to_board(MARK, 3, 4, 5)
    expect(board.winner).to be MARK
  end
  
  it 'board returns winner if bottom row is occupied by player' do
    add_moves_to_board(MARK, 6, 7, 8)
    expect(board.winner).to be MARK
  end

  it 'board returns winner if left column is occupied by player' do
    add_moves_to_board(MARK, 0, 3, 6)
    expect(board.winner).to be MARK
  end

  it 'board returns winner if middle column is occupied by player' do
    add_moves_to_board(MARK, 1, 4, 7)
    expect(board.winner).to be MARK
  end

  it 'board returns winner if right column is occupied by player' do
    add_moves_to_board(MARK, 2, 5, 8)
    expect(board.winner).to be MARK
  end

  it 'board returns winner if diagonal line starting at top left is occupied by player' do
    add_moves_to_board(MARK, 0, 4, 8)
    expect(board.winner).to be MARK
  end

  it 'board returns winner if diagonal line starting at top right is occupied by player' do
    add_moves_to_board(MARK, 2, 4, 6)
    expect(board.winner).to be MARK
  end

  it 'board returns false if move is below lower bounds' do
    expect(board.is_move_valid?(-1)).to be false
  end
  
  it 'board returns false if move is exceeds upper bounds' do
    expect(board.is_move_valid?(9)).to be false
  end

  it 'board returns true if move is within lower bounds' do
    expect(board.is_move_valid?(0)).to be true
  end

  it 'board returns true if move is within upper bounds' do
    expect(board.is_move_valid?(8)).to be true
  end

  it 'board returns false if move is occupied already' do
    add_moves_to_board(MARK, 0)
    expect(board.is_move_valid?(0)).to be false
  end

  it 'board returns empty positions' do
    add_moves_to_board(MARK, 0)
    expect(board.empty_positions.size).to eq(board.positions.size - 1)
    expect(board.empty_positions).to_not include(0)
  end

  it 'board can be created from other board' do
    add_moves_to_board(MARK, 0)
    board_duplicate = TTT::Board.new(board.positions)
    expect(board_duplicate).to eq(board)
    board_duplicate.add_move(MARK,1)
    expect(board.positions[1]).to_not eq(MARK)
  end

  it 'board returns default opponent' do
    opponent = board.find_opponent(:this_player, :default_opponent)
    expect(opponent).to be(:default_opponent)
  end

  it 'board returns opponent when it exists' do
    add_moves_to_board(MARK, 0)
    opponent = board.find_opponent(:this_player, :default_opponent)
    expect(opponent).to be(MARK)
  end
  
  def add_moves_to_board(player, *moves)
    moves.each do |move|
      board.add_move(player, move)
    end
  end
end
