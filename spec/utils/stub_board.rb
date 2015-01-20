module TTT
  class StubBoard

    attr_accessor :added_moves
    attr_accessor :is_a_tie
    def initialize
      @game_over_sequence = []
      @added_moves = Hash.new
      @is_a_tie = false
    end

    def game_over?
      @game_over_sequence.shift
    end

    def game_over_sequence(*game_over_sequence)
      @game_over_sequence = game_over_sequence
    end

    def add_move(player, position)
      @added_moves[position] = player
    end

    def set_winner(player)
      @winner = player
    end

    def find_winner
      @winner
    end
  end
end
