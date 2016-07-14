require 'oystercard'

describe Oystercard do

  default_topup = 10
  let(:station) {double :station, zone: 1}
  let(:station_2) { double(:station) }
  let(:current_journey){ {:entry_station => station, :exit_station => station_2} }

  it 'raise error if balance exceeds max amount' do
    max_balance = Oystercard::BALANCE_LIMIT
    expect{ subject.top_up(max_balance + 1) }.to raise_error("Exceeds max allowed amount of #{max_balance}")
  end

  it 'returns the initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'not be able to touch in when balance is below £1' do
    expect{ subject.touch_in(station) }.to raise_error("Balance is below £#{Journey::MINIMUM_FARE}")
  end

  context 'For journey' do
    before do
      subject.top_up(default_topup)
      subject.touch_in(station)
    end

    it "should have empty journeys by default" do
      expect(subject.journeys).to be_empty
    end

    it "is getting charged" do
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by (-Journey::MINIMUM_FARE)
    end

    it "stores entry and exit stations" do
      subject.touch_out(station_2)
      expect(subject.journeys).to include current_journey
    end

  end

end
