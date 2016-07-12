require "oystercard"

describe Oystercard do

  subject(:card) { Oystercard.new }

  it 'has a default balance of 0' do
    expect(card.balance).to eq 0
  end

  it "can be topped up" do
    random_number = rand(1000)
    expect{card.top_up(random_number)}.to change{card.balance}.by random_number
  end

end
