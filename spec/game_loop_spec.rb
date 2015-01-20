require_relative '../lib/game_loop.rb'
require_relative 'utils/test_game.rb'

describe TTT::GameLoop do
  let(:game){TTT::TestUtils::TestGame.new}
  let(:game_loop) { TTT::GameLoop.new(game) }
  
  it 'game not rendered if game is over immediately' do
    game.game_over_simulated_sequence(true)
    game_loop.run
    expect(game.number_of_renders).to eq 0
    expect(game.display_outcome_count).to eq 1
  end

  it 'game is rendered once if game and player move is invoked' do
    game.game_over_simulated_sequence(false, true)
    game_loop.run
    expect(game.number_of_player_moves).to eq 1
    expect(game.number_of_renders).to eq 1
    expect(game.display_outcome_count).to eq 1
  end
end
