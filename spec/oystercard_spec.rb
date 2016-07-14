require 'oystercard'

describe Oystercard do

  let(:station) {double :station, zone: 1}
  let(:station_2) { double(:station) }
  let(:current_journey){ {:entry_station => station, :exit_station => station_2} }
  default_topup = 10


  it 'raise error if balance exceeds max amount' do
    max_balance = Oystercard::BALANCE_LIMIT
    expect{ subject.top_up(max_balance + 1) }.to raise_error("Exceeds max allowed amount of #{max_balance}")
  end

  it 'returns the initial balance of 0' do
    expect(subject.balance).to eq 0
  end



  it 'not be able to touch in when balance is below £1' do
    expect{ subject.touch_in(station) }.to raise_error("Balance is below £#{Oystercard::MINIMUM_FARE}")
  end


  context 'Touch functionality in/out' do
    before do
      subject.top_up(default_topup)
      subject.touch_in(station)
    end


    # it 'should set card to in journey when touched in' do
    #   expect(subject).to be_in_journey
    # end

    it "is getting charged for the journey" do
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by -(Oystercard::MINIMUM_FARE)
    end

  end

  context '#journeys' do
    xit "stores entry and exit stations" do
      subject.top_up(default_topup)
      subject.touch_in(station)
      subject.touch_out(station_2)
      expect(subject.journeys).to include current_journey
    end

    it "should have empty journeys" do
      expect(subject.journeys).to be_empty
    end
  end

end
