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

  it 'board returns nil if no winner on board' do
    expect(board.find_winner).to be nil
  end

  it 'board returns winner if top row is occupied by player' do
    add_moves_to_board(0,1,2)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if middle row is occupied by player' do
    add_moves_to_board(3,4,5)
    expect(board.find_winner).to be PLAYER
  end
  
  it 'board returns winner if bottom row is occupied by player' do
    add_moves_to_board(6,7,8)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if left column is occupied by player' do
    add_moves_to_board(0,3,6)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if middle column is occupied by player' do
    add_moves_to_board(1,4,7)
    expect(board.find_winner).to be PLAYER
  end

  it 'board returns winner if right column is occupied by player' do
    add_moves_to_board(2,5,8)
    expect(board.find_winner).to be PLAYER
  end

  def add_moves_to_board(i,j,k)
    board.add_move(PLAYER,i)
    board.add_move(PLAYER,j)
    board.add_move(PLAYER,k)
  end
end
