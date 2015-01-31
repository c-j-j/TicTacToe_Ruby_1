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

      def print_winner_message(mark)
        @status_label.text = WINNING_MESSAGE % mark
      end

      def print_tie_message
        @status_label.text = DRAW_MESSAGE
      end

      private

      def display_invalid_move_message
      end

      #TODO this will be replaced by getting rows from selected board
      def init_board
        board_grid = Qt::GridLayout.new(self)
        0.upto(2) do |row|
          0.upto(2) do |column|
            cell = TTT::UI::QTCell.new(self, row)
            board_grid.addWidget(cell, row, column)
            cell.text = ''
            @cells << cell
          end
        end
      end

    end
  end
end
#app = Qt::Application.new ARGV
#TTT::QT_Interface.new
#app.exec
