require_relative '../lib/game.rb'
require_relative 'stubs/stub_interface.rb'

describe "Integration Tests" do
  let(:user_interface) { TTT::StubInterface.new }

  it 'run through hvh game where player X wins' do
    user_interface.specify_game_type('1')
    hvh_game = TTT::Game.build_game_for_user(user_interface)
    user_interface.set_user_moves(0, 1, 2, 3, 4, 5, 6, 7, 8)
    hvh_game.play
    expect(user_interface.print_winner_message_results.size).to eq(1)
  end

  it 'run through hvh game where there is a tie' do
    user_interface.specify_game_type('1')
    hvh_game = TTT::Game.build_game_for_user(user_interface)
    user_interface.set_user_moves(0, 1, 2, 3, 5, 4, 7, 8, 6)
    hvh_game.play
    expect(user_interface.print_winner_message_results.size).to eq(0)
    expect(user_interface.print_tie_message_count).to eq(1)
  end

  it 'runs through cvc game and ends in draw' do
    user_interface.specify_game_type('4')
    cvc_game  = TTT::Game.build_game_for_user(user_interface)
    cvc_game.play
    expect(user_interface.print_winner_message_results.size).to eq(0)
    expect(user_interface.print_tie_message_count).to eq(1)
  end

end
