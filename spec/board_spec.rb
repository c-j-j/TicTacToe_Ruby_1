require '../lib/board.rb'

describe TTT::Board do
  it 'marks board with player move' do
    board = TTT::Board.new
    player = 'some player'
    board.add_move(player, 0)
    expect(board.get_player_in_position(0)).to be(player)
  end
end
