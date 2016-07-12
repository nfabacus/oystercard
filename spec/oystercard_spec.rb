require "oystercard"

describe Oystercard do

  subject(:card) { Oystercard.new }
  random_number = rand(Oystercard::LIMIT)

  it 'has a default balance of 0' do
    expect(card.balance).to eq 0
  end

  it "can be topped up" do
    expect{ card.top_up(random_number) }.to change{ card.balance }.by random_number
  end

  it "raises error when trying to top up beyond limit" do
    card.top_up(Oystercard::LIMIT)
    expect{ card.top_up(1) }.to raise_error "Top up would exceed card limit of £#{Oystercard::LIMIT}"
  end

  it "Deduct the fare from the card" do
    expect{ card.deduct(random_number) }.to change{ card.balance }.by -random_number
  end

end
