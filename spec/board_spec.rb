require_relative '../lib/board.rb'

describe TTT::Board do
  let(:board) { TTT::Board.new }
  PLAYER = 'some player'

  it 'marks board with player move 0' do
    player_move = 0
    board.add_move(PLAYER, player_move)
    expect(board.get_player_in_position(player_move)).to be(PLAYER)
  end
  
  it 'marks board with player move 8' do
    player_move = 8
    board.add_move(PLAYER, player_move)
    expect(board.get_player_in_position(player_move)).to be(PLAYER)
  end

  it 'board returns false if game not over' do
    expect(board.game_over?).to be false
  end

  it 'game not over when single mark on board' do
    board.add_move(PLAYER,0)
    expect(board.game_over?).to be false
  end

  it 'board returns true if game over due to win' do
    add_moves_to_board(PLAYER, 0, 1, 2)
    expect(board.game_over?).to be true
  end

  it 'game is not a tie when board is empty' do
    expect(board.is_a_tie?).to be false
  end

  it 'game is a tie when board is full and no winner' do
    add_moves_to_board(PLAYER, 0,1,5,6,8)
    add_moves_to_board("some other player", 2,3,4,7)
    expect(board.is_a_tie?).to be true 
  end

  it 'game is a not a tie when board is full and winner exists' do
    add_moves_to_board(PLAYER, 0,1,2,3,4,5,6,7,8)
    expect(board.is_a_tie?).to be false
  end

  it 'to_s prints board out using player.to_s' do
    add_moves_to_board('a', 0, 1, 2, 6, 7, 8)
    add_moves_to_board('b', 3, 4, 5)
    expect(board.to_s).to eq " a  a  a \n b  b  b \n a  a  a \n"
  end

  it 'empty board has numbers instead of blank strings' do
    expect(board.to_s).to eq " 0  1  2 \n 3  4  5 \n 6  7  8 \n"
  end

  it 'board returns true if game over due to draw' do
    add_moves_to_board(PLAYER, 0,1,5,6,8)
    add_moves_to_board("some other player", 2,3,4,7)
    expect(board.game_over?).to be true
  end
  
  it 'board returns nil if no winner on board' do
    expect(board.find_winner).to be nil
  end

  it 'board returns winner if top row is occupied by player' do
    add_moves_to_board(PLAYER, 0,1,2)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if middle row is occupied by player' do
    add_moves_to_board(PLAYER, 3,4,5)
    expect(board.find_winner).to be PLAYER
  end
  
  it 'board returns winner if bottom row is occupied by player' do
    add_moves_to_board(PLAYER, 6,7,8)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if left column is occupied by player' do
    add_moves_to_board(PLAYER, 0,3,6)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if middle column is occupied by player' do
    add_moves_to_board(PLAYER, 1,4,7)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if right column is occupied by player' do
    add_moves_to_board(PLAYER, 2,5,8)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if diagonal line starting at top left is occupied by player' do
    add_moves_to_board(PLAYER, 0,4,8)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if diagonal line starting at top right is occupied by player' do
    add_moves_to_board(PLAYER, 2, 4, 6)
    expect(board.find_winner).to be PLAYER
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
    add_moves_to_board(PLAYER, 0)
    expect(board.is_move_valid?(0)).to be false
  end

  def add_moves_to_board(player, *moves)
    moves.each do |move|
      board.add_move(player, move)
    end
  end
end
