require "oystercard"

describe Oystercard do

  subject(:card) { Oystercard.new }

  it 'has a default balance of 0' do
    expect(card.balance).to eq 0
  end

end
