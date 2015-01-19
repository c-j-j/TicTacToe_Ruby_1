require_relative '../lib/game.rb'

describe TTT::Game do
  let(:board) { double('board') }
  let(:player_1) {double('player_1')}
  let(:player_2) {double('player_2')}
  let(:display) {double('display')}
  let(:game) { TTT::Game.new(display, board, player_1, player_2) }

  it 'delegates game over call to embedded board' do
    expect(board).to receive(:game_over?)
    game.game_over?
  end

  it 'delegates first move to player 1' do
    player_move = 0
    expect(player_1).to receive(:next_move).and_return(player_move)
    expect(board).to receive(:add_move).with(player_1, player_move)
    game.update_with_next_player_move
  end
  
  it 'delegates second move to player 2' do
    player_move = 1
    expect(player_1).to receive(:next_move).and_return(player_move)
    expect(player_2).to receive(:next_move).and_return(player_move)
    expect(board).to receive(:add_move).with(player_1, player_move)
    expect(board).to receive(:add_move).with(player_2, player_move)
    game.update_with_next_player_move
    game.update_with_next_player_move
  end

  it 'delegates render to cli renderer' do
    expect(display).to receive(:render).with(board)
    game.render
  end

  it 'delegates display_outcome to cli renderer and prints out tie game' do
    expect(display).to receive(:render).with(TTT::Game::TIE_MESSAGE)
    expect(board).to receive(:is_a_tie?).and_return(true)

    game.display_outcome
  end

  it 'delegates display_outcome to cli renderer and prints out winner' do
    expect(display).to receive(:render).with(TTT::Game::WINNING_MESSAGE % player_1)
    expect(board).to receive(:is_a_tie?).and_return(false)
    expect(board).to receive(:find_winner).and_return(player_1)

    game.display_outcome
  end
end
