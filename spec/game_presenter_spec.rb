require 'game_presenter'
require 'game'
require 'ui/constants'

describe TTT::GamePresenter do

  it 'creates game presenter with board' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_board('board')
      .build
    expect(game_presenter.board).to eq('board')
  end

  it 'creates game presenter with state' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_state('state')
      .build
    expect(game_presenter.state).to eq('state')
  end

  it 'creates game presenter with winner' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_winner('winner')
      .build
    expect(game_presenter.winner).to eq('winner')
  end

  it 'creates game presenter with current_player_mark' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_current_player_mark('current_player_mark')
      .build
    expect(game_presenter.current_player_mark).to eq('current_player_mark')
  end

  it 'creates game presenter with current_player_is_computer' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_current_player_is_computer('current_player_is_computer')
      .build
    expect(game_presenter.current_player_is_computer).to eq('current_player_is_computer')
  end

  it 'creates game presenter with row_size' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_row_size('row_size')
      .build
    expect(game_presenter.row_size).to eq('row_size')
  end

  it 'status is draw message when state is a draw' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_state(TTT::Game::DRAW)
      .build
        
    expect(game_presenter.status).to eq(TTT::UI::TIE_MESSAGE)
  end

  it 'status is winner when state is a win' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_state(TTT::Game::WON)
      .with_winner('X')
      .build
    expect(game_presenter.status).to eq(TTT::UI::WINNING_MESSAGE % 'X')
  end

  it 'status displays current player to go' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_state(TTT::Game::IN_PROGRESS)
      .with_current_player_mark('O')
      .build
    expect(game_presenter.status).to eq(TTT::UI::NEXT_PLAYER_TO_GO % 'O')
  end

  it 'computer has next go when current player is computer' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_current_player_is_computer(true)
      .build

   expect(game_presenter.computer_has_next_turn?).to eq(true)
  end

  it 'computer does not have next turn when game has been won' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_current_player_is_computer(true)
      .with_state(TTT::Game::WON)
      .build

    expect(game_presenter.computer_has_next_turn?).to eq(false)
  end

  it 'computer does not have next turn game has ended in draw' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_current_player_is_computer(true)
      .with_state(TTT::Game::DRAW)
      .build

    expect(game_presenter.computer_has_next_turn?).to eq(false)
  end

  it 'cell size is 32% when board is 3x3' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_row_size(3)
      .build

    expect(game_presenter.cell_size).to eq('32%')
  end

  it 'cell size is 24% when board is 4x4' do
    game_presenter = TTT::GamePresenter::Builder.new
      .with_row_size(4)
      .build

    expect(game_presenter.cell_size).to eq('24%')
  end
end
