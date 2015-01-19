module TTT
  module TestUtils
    class TestGame
      
      attr_accessor :number_of_player_moves
      def initialize
        @renders = 0
        @display_outcome_count = 0
        @number_of_player_moves = 0
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

      def update_with_next_player_move
        @number_of_player_moves += 1
      end

      def display_outcome_count
        @display_outcome_count
      end
    end
  end
end
