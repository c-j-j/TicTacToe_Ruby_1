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
