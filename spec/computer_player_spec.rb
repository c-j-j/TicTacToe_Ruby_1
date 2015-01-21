require_relative '../lib/computer_player.rb'
require_relative '../lib/board.rb'
require_relative 'utils/board_helper.rb'

describe TTT::ComputerPlayer do

  let(:board) {TTT::Board.new()}
  let(:board_helper) {TTT::BoardHelper.new(board)}
  let(:computer_player) { TTT::ComputerPlayer.new(board) }

  it 'score is 0 when game is initially a tie' do
    board_helper.populate_board_with_tie(computer_player, :opponent)
    score = computer_player.minimax
    expect(score).to eq(TTT::ComputerPlayer::DRAW_SCORE)
  end

  it 'score is positive when this player initially wins' do
    board_helper.populate_board_with_win(computer_player)
    score = computer_player.minimax
    expect(score).to eq(TTT::ComputerPlayer::WIN_SCORE)
  end

  it 'score is negative when this player initially loses' do
    board_helper.populate_board_with_loss
    score = computer_player.minimax
    expect(score).to eq(TTT::ComputerPlayer::LOSE_SCORE)
  end

  it 'wins when it can' do
    board_helper.add_moves_to_board([0, 1], computer_player)
    move = computer_player.next_move
    expect(move).to eq(2)
  end

  it 'forks so it can win during next move' do
    board_helper.add_moves_to_board([0, 3], computer_player)
    move = computer_player.next_move
    expect(move).to eq(2)
  end

  it 'blocks opponent from winning' do
    board_helper.add_moves_to_board([0, 3], :opponent)
    move = computer_player.next_move
    expect(move).to eq(6)
  end
end
