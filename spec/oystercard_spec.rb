require 'oystercard'

describe Oystercard do

  let(:station) { double(:station) }

  it 'returns the initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  context "Modification's to balance" do
    before do
      subject.top_up(Oystercard::BALANCE_LIMIT)
    end

    it 'raise error if balance exceeds max amount' do
      max_balance = Oystercard::BALANCE_LIMIT
      expect{ subject.top_up(1) }.to raise_error("Exceeds max allowed amount of #{max_balance}")
    end
  end

  context 'Touch functionality in/out' do

    it 'should not be in journey when initiated' do
      expect(subject).not_to be_in_journey
    end

    it 'should set card to in journey when touched in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'should set card to NOT be in journey when touched out' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  it 'Not be able to touch in when balance is below £1' do
    expect{ subject.touch_in(station) }.to raise_error('Balance is below £1, unable to touch in')
  end

  it "is getting charged for the journey" do
    subject.top_up(10)
    subject.touch_in(station)
    expect{ subject.touch_out }.to change{ subject.balance }.by -(Oystercard::MINIMUM_FARE)
  end

  it 'Remebers the station that was touched in' do
    subject.top_up(10)
    expect(subject.touch_in(station)).to eq station
  end

  it 'Sets station to nil on touch out' do
    subject.top_up(10)
    subject.touch_in(station)
    expect{ subject.touch_out }.to change{ subject.station }.from(station).to(nil)
  end

end
