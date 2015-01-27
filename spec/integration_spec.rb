require_relative '../lib/game_factory.rb'
require_relative 'stubs/stub_interface.rb'

describe "Integration Tests" do
  let(:display) { TTT::StubInterface.new }

  it 'run through hvh game where player X wins' do
    display.specify_game_type('1')
    hvh_game = TTT::GameFactory.new(display).build_game_for_user
    display.set_user_input('0', '1','2','3','4','5','6','7','8')
    hvh_game.play
    expect(display.print_winner_message_results.size).to eq(1)
  end

  it 'run through hvh game where there is a tie' do
    display.specify_game_type('1')
    hvh_game = TTT::GameFactory.new(display).build_game_for_user
    display.set_user_input('0','1','2','3','5','4','7','8','6')
    hvh_game.play
    expect(display.print_winner_message_results.size).to eq(0)
    expect(display.print_tie_message_count).to eq(1)
  end

  it 'runs through cvc game and ends in draw' do
    display.specify_game_type('2')
    cvc_game = TTT::GameFactory.new(display).build_game_for_user
    cvc_game.play
    expect(display.print_winner_message_results.size).to eq(0)
    expect(display.print_tie_message_count).to eq(1)
  end

end
