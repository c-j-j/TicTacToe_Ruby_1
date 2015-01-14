require_relative '../lib/game_loop.rb'

module TTT
  module TestUtils
    class TestGame
      
      def initialize
        @renders = 0
        @player_1_updates = 0
        @player_2_updates = 0
        @display_outcome_count = 0
        @game_over_sequence = []
      end

      def game_over_simulated_sequence(*game_over_sequence)
        @game_over_sequence = game_over_sequence
      end

      def render
        @renders += 1
      end

      def game_over?
        @game_over_sequence.shift
      end

      def display_outcome
        @display_outcome_count += 1
      end

      def number_of_renders
        @renders
      end

      def display_outcome_count
        @display_outcome_count
      end

      def update_with_player_1_input
        @player_1_updates += 1
      end

      def number_of_player_1_updates
        @player_1_updates
      end
      
      def update_with_player_2_input
        @player_2_updates += 1
      end
      
      def number_of_player_2_updates
        @player_2_updates
      end
    end
  end
end

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
