require 'station'
require 'oystercard'
require 'journey'

describe 'Feature test' do
  default_top_up = 20
  let(:card) { Oystercard.new }
  let(:departure_station) { Station.new('London', 1) }
  let(:arrival_station) { Station.new('Birmingham', 2) }

  it "I want money on my card" do
    expect{ card.top_up(default_top_up) }.to change{ card.balance }.by(default_top_up)
  end

  it "I don't want to put too much money on my card" do
    expect{ card.top_up(100) }.to raise_error("Exceeds max allowed amount of #{Oystercard::BALANCE_LIMIT}")
  end

  it "I need my fare deducted from my card" do
    card.top_up(default_top_up)
    card.touch_in(departure_station)
    expect{ card.touch_out(arrival_station) }.to change{ card.balance }.by(-Journey::MINIMUM_FARE)
  end

  it "I need to touch in and out" do
    
  end
end
