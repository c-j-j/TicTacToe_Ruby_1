require 'spec_helper'
require 'web/rack/web_interface'
require 'web/rack/erb_file_parser'
require 'board'

describe TTT::Web::WebInterface do
  let(:board) { TTT::Board.new }
  let(:game) { instance_double('TTT::Game') }
  let(:erb_file_parser) {instance_double('TTT::Web::ERBFileParser') }
  let(:web_interface) { TTT::Web::WebInterface.new }

  it 'stages board for viewing' do
    web_interface.print_board('board')
    expect(web_interface.board).to eq('board')
  end

  it 'stages status to print win message' do
    web_interface.print_winner_message('winner')
    expect(web_interface.status).to eq(TTT::UI::WINNING_MESSAGE % 'winner')
  end

  it 'stages status to print tie message' do
    web_interface.print_tie_message
    expect(web_interface.status).to eq(TTT::UI::TIE_MESSAGE)
  end

  it 'stages status to print next player' do
    web_interface.print_next_player_to_go('next player')
    expect(web_interface.status).to eq(TTT::UI::NEXT_PLAYER_TO_GO % 'next player')
  end

  it 'stages status to print invalid move' do
    web_interface.print_invalid_move_message
    expect(web_interface.status).to eq(TTT::UI::INVALID_MOVE_MESSAGE)
  end

  it 'plays a user chosen move against the game' do
    expect(game).to receive(:play_turn).with(1)
    web_interface.submit_move(game, 1)
  end

  it 'plays game when play_turn is called' do
    expect(game).to receive(:play2)
    web_interface.play_turn(game)
  end

  it 'parses html' do
    expect(game).to receive(:play2)
    web_interface.print_tie_message
    response = web_interface.play_turn(game)
    expect(response).to include(TTT::UI::TIE_MESSAGE)
  end
end
