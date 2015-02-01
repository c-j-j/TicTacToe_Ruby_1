require 'qt'
require_relative 'qt_cell.rb'
require_relative '../game.rb'

module TTT
  module UI
    class QT_Interface < Qt::Widget
      attr_reader :cells
      attr_reader :status_label
      attr_reader :game_state
      attr_reader :play_button

      slots "start_game()"

      WINNING_MESSAGE = "%s has won"
      DRAW_MESSAGE = 'Game ended in draw'
      NEXT_PLAYER_TO_GO_MESSAGE = "%s's turn"
      INVALID_MOVE_MESSAGE = 'Invalid move'

      def initialize(game)
        super(nil)
        @cells = []
        if game.nil?
          #TODO use factory mehtods in game, and will be set by user later
          board = TTT::Board.new(3)
          @game = TTT::Game.new(board, self, nil, nil)
        else
          @game = game
        end
        @board = @game.board
        init_screen
        show
      end

      def init_screen
        setWindowTitle "Tic Tac Toe"
        resize 300, 280
        init_board
        @status_label = Qt::Label.new("Status", self)
        @play_button = Qt::PushButton.new('Play', self)
        @status_label.move(100, 0)
        connect(@play_button, SIGNAL(:pressed), self, SLOT("start_game()"))
      end

      def board_clicked(position)
        if !@game.move_valid?(position)
          print_invalid_move_message
          return
        end

        return if @game_state != :AWAITING_USER_MOVE

        @game.play_turn(position)
      end

      def print_next_player_to_go(mark)
        update_status(NEXT_PLAYER_TO_GO_MESSAGE % mark)
      end

      def print_winner_message(mark)
        update_status(WINNING_MESSAGE % mark)
      end

      def print_tie_message
        update_status(DRAW_MESSAGE)
      end

      def print_invalid_move_message
        update_status(INVALID_MOVE_MESSAGE)
      end

      def print_board(board)
        cells.each_with_index do |cell, index|
          cell.text = board.positions[index]
        end
      end

      def get_user_move(_)
        @game_state = :AWAITING_USER_MOVE
      end

      def start_game
        @game.play
      end

      private

      def update_status(message)
        @status_label.text = message
      end

      def init_board
        board_grid = Qt::GridLayout.new(self)

        0.upto(board_size) do |cell_index|
            cell = TTT::UI::QTCell.new(self, cell_index)
            row, column = get_row_and_column_from_index(cell_index)
            board_grid.addWidget(cell, row, column)
            @cells << cell
        end
      end

      def get_row_and_column_from_index(cell_index)
        cell_index.divmod(@board.rows.size)
      end

      def board_size
        @board.positions.size - 1
      end

    end
  end
end
