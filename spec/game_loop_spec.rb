require_relative '../lib/game_loop.rb'
require_relative 'utils/test_game.rb'

describe TTT::GameLoop do
  let(:game){TTT::TestUtils::TestGame.new}
  let(:game_loop) { TTT::GameLoop.new(game) }
  
  it 'game is rendered once if game is immediately over' do
    game.game_over_simulated_sequence(true)
    game_loop.run
    expect(game.number_of_renders).to eq 1
    expect(game.display_outcome_count).to eq 1
  end

  it 'game is rendered twice if game is not over initially' do
    game.game_over_simulated_sequence(false, true)
    game_loop.run
    expect(game.number_of_renders).to eq 2
  end

  it 'game is updated with player 1 input only when player 1 wins game immediately' do
    game.game_over_simulated_sequence(false, true)
    game_loop.run
    expect(game.number_of_renders).to eq 2
    expect(game.number_of_player_1_updates).to eq 1 
  end

  it 'game is updated with player 1 and player 2 input where player 2 wins game' do
    game.game_over_simulated_sequence(false, false, true)
    game_loop.run
    expect(game.number_of_renders).to eq 3
    expect(game.number_of_player_1_updates).to eq 1 
    expect(game.number_of_player_2_updates).to eq 1 
  end
end
