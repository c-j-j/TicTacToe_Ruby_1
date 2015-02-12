require 'human_player'
require 'game_presenter'
require 'computer_player'
require 'board.rb'

module TTT
  class Game

    attr_accessor :current_player
    attr_reader :board
    attr_reader :player_1
    attr_reader :player_2
    attr_reader :game_type

    MOVE_NOT_AVAILABLE = -1

    HVH = 'Human Vs Human'
    HVC = 'Human Vs Computer'
    CVH = 'Computer Vs Human'
    CVC = 'Computer Vs Computer'

    COMPUTER_PLAYER = 'Computer Player'

    GAME_TYPES = [
      HVH,
      HVC,
      CVH,
      CVC
    ]

    BOARD_SIZES = [
      3,
      4
    ]

    WON = :won
    DRAW = :draw
    IN_PROGRESS = :in_progress

    X = 'X'
    O = 'O'

    MARKS = [X, O]

    def self.build_game(user_interface, game_type, board_size)
      build_game_with_board(user_interface, game_type, Board.new(board_size))
    end

    def self.build_game_with_board(user_interface, game_type, board)
      case game_type
      when HVH
        new_game(user_interface, new_human_player(user_interface),
                 new_human_player(user_interface), board)
      when HVC
        new_game(user_interface, new_human_player(user_interface),
                 new_computer_player, board)
      when CVH
        new_game(user_interface, new_computer_player,
                 new_human_player(user_interface), board)
      when CVC
        new_game(user_interface, new_computer_player,
                 new_computer_player, board)
      end
    end

    def self.default_board_size
      BOARD_SIZES[0]
    end

    def self.default_game_type
      GAME_TYPES[0]
    end

    def initialize(board, user_interface, player_1, player_2)
      @board = board
      @user_interface = user_interface
      @player_1 = player_1
      @player_2 = player_2
      @current_player = determine_current_player(board)
      @state = IN_PROGRESS
    end

    def determine_current_player(board)
      if board.num_of_occupied_positions.even?
        return @player_1
      else
        return @player_2
      end
    end

    def play_turn(move = nil)
      process_turn(move) unless game_over?
      update_state
    end

    def presenter
      TTT::GamePresenter::Builder.new
        .with_board(@board)
        .with_row_size(row_size)
        .with_current_player_is_computer(determine_if_computer_player(@current_player))
        .with_current_player_mark(@current_player.mark)
        .with_state(@state)
        .with_winner(@winner)
        .build
    end

    def swap_current_player
      if @current_player == @player_1
        @current_player = @player_2
      else
        @current_player = @player_1
      end
    end

    def row_size
      @board.rows.size
    end

    def number_of_positions
      @board.number_of_positions
    end

    def move_valid?(position)
      position.nil? || @board.is_move_valid?(position)
    end

    def get_next_move
      @user_interface.print_next_player_to_go(@current_player.mark)
      @current_player.next_move(@board)
    end

    def add_move_to_board(position)
      @board.add_move(@current_player.mark, position)
    end

    def game_over?
      @board.game_over?
    end

    def board_positions
      @board.positions
    end

    private

    def process_turn(move)
      move = move || @current_player.next_move(@board)
      if move != MOVE_NOT_AVAILABLE
        add_move_to_board(move)
        swap_current_player
      end
    end

    def determine_if_computer_player(player)
      class_name = player.class.name
      class_name == TTT::ComputerPlayer.name
    end

    def update_state
      if @board.won?
        @state = WON
        @winner = @board.winner
      end
      @state = DRAW if @board.draw?
    end

    def self.new_human_player(user_interface)
      TTT::HumanPlayer.new(user_interface, next_mark)
    end

    def self.new_computer_player
      mark = next_mark
      opponent_mark = get_opponent_mark(mark)
      p1 = TTT::ComputerPlayer.new(mark, opponent_mark)
    end

    def self.get_opponent_mark(mark)
      MARKS.find do |current_mark|
        current_mark != mark
      end
    end

    def self.next_mark
      next_mark = MARKS.shift
      MARKS.push(next_mark)
      next_mark
    end

    def self.new_game(user_interface, player_1, player_2, board)
      TTT::Game.new(board, user_interface, player_1, player_2)
    end
  end
end
