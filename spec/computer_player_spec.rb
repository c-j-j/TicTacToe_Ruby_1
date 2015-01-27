require_relative '../lib/computer_player.rb'
require_relative '../lib/board.rb'
require_relative 'utils/board_helper.rb'
require_relative 'stubs/stub_player.rb'

describe TTT::ComputerPlayer do
  let(:mark){'X'}

  let(:board) {TTT::Board.new}
  let(:board_helper) {TTT::BoardHelper.new(board)}
  let(:opponent) {TTT::StubPlayer.new('O')}
  let(:computer_player) { TTT::ComputerPlayer.new(board, mark) }

  it 'has a mark' do
    expect(computer_player.mark).to be(mark)
  end

  it 'score is 0 when game is initially a tie' do
    board_helper.populate_board_with_tie(computer_player.mark, opponent.mark)
    move = computer_player.negamax(board, mark)
    expect(move.score).to eq(TTT::ComputerPlayer::DRAW_SCORE)
  end

  it 'score is positive when this player initially wins' do
    board_helper.populate_board_with_win(computer_player.mark)
    move = computer_player.negamax(board, mark)
    expect(move.score).to eq(TTT::ComputerPlayer::WIN_SCORE)
  end

  it 'score is negative when this player initially loses' do
    board_helper.populate_board_with_loss
    move = computer_player.negamax(board, mark)
    expect(move.score).to eq(TTT::ComputerPlayer::LOSE_SCORE)
  end

  it 'wins by taking the first row' do
    board_helper.add_moves_to_board([0, 1], computer_player.mark)
    move = computer_player.next_move
    expect(move).to eq(2)
  end

  it 'wins by going in the centre' do
    board_helper.add_moves_to_board([0, 8], computer_player.mark)
    board_helper.add_moves_to_board([2, 6], opponent.mark)
    move = computer_player.next_move
    expect(move).to eq(4)
  end

  it 'forks to give multiple chances to win' do
    board_helper.add_moves_to_board([0, 4], computer_player.mark)
    board_helper.add_moves_to_board([1, 8], opponent.mark)
    move = computer_player.next_move
    expect(move).to eq(3)
  end

  it 'blocks opponent from winning' do
    board_helper.add_moves_to_board([0, 3], opponent.mark)
    board_helper.add_moves_to_board([4], computer_player.mark)
    move = computer_player.next_move
    expect(move).to eq(6)
  end

  it 'goes centre when board is empty' do
    move = computer_player.next_move
    expect(move).to eq(0)
  end

  it 'goes centre when opponent is in top left' do
    board_helper.add_moves_to_board([0], :an_opponent)
    move = computer_player.next_move
    expect(move).to eq(4)
  end
end
