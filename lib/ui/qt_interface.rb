require 'qt'
require_relative 'qt_cell.rb'
require_relative '../game.rb'

module TTT
  module UI
    class QT_Interface < Qt::Widget
      attr_reader :cells
      attr_reader :status_label

      WINNING_MESSAGE = "%s has won"
      DRAW_MESSAGE = 'Game ended in draw'
      NEXT_PLAYER_TO_GO_MESSAGE = "%s's turn"
      INVALID_MOVE_MESSAGE = 'Invalid move'

      def initialize(game)
        super(nil)
        @cells = []
        if game.nil?
          @game = TTT::Game.new(nil, self, nil, nil)
        else
          @game = game
        end
        init_screen
        show
      end

      def init_screen
        setWindowTitle "Tic Tac Toe"
        init_board
        hbox = Qt::HBoxLayout.new
        @status_label = Qt::Label.new "Status", self
      end

      def board_clicked(position)
        if !@game.move_valid?(position) #todo print invalid message
          print_invalid_move_message
          return
        end

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

      private

      def update_status(message)
        @status_label.text = message
      end

      #TODO this will be replaced by getting rows from selected board
      def init_board
        board_grid = Qt::GridLayout.new(self)
        0.upto(2) do |row|
          0.upto(2) do |column|
            cell = TTT::UI::QTCell.new(self, row)
            board_grid.addWidget(cell, row, column)
            cell.text = '-'
            @cells << cell
          end
        end
      end

    end
  end
end
