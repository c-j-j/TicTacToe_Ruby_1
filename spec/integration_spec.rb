require_relative '../lib/game_factory.rb'
require_relative 'utils/stub_display.rb'

describe TTT::GameFactory do
  let(:display) { TTT::StubDisplay.new }
  let(:hvh_game) { TTT::GameFactory.new(display).build_hvh_game }
  let(:cvc_game) { TTT::GameFactory.new(display).build_cvc_game }

  it 'run through hvh game where player X wins' do
    display.set_user_input('0', '1','2','3','4','5','6','7','8')
    hvh_game.play
    expect(display.print_winner_message_results.size).to eq(1)
  end

  it 'run through game where there is a tie' do
    display.set_user_input('0','1','2','3','5','4','7','8','6')
    hvh_game.play
    expect(display.print_winner_message_results.size).to eq(0)
    expect(display.print_tie_message_count).to eq(1)
  end

  it 'runs through cvc game and ends in draw' do
    cvc_game.play  
    expect(display.print_winner_message_results.size).to eq(0)
    expect(display.print_tie_message_count).to eq(1)
  end

end
