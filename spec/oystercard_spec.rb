require 'oystercard'
TOP_UP = 5
describe Oystercard do

    it 'should have default value of 0' do
      expect(subject.balance).to eq(0)
    end


  describe '#top_up' do

    it 'should add money to balance' do
      expect { subject.top_up(TOP_UP) }.to change { subject.balance }.by TOP_UP
    end

    it 'should throw an error, if balance is exceed limit' do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up TOP_UP }.to raise_error "Exceeds limit: #{limit}"
    end
  end

  context 'while in journey' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

    describe '#in_journey?' do

      it 'should start with an empty journey array' do
        expect(subject.journey).to be_empty
      end

      it 'should have default value of false' do
        expect(subject.in_journey?).to eq false
      end
    end

    describe '#touch_in' do
      it 'should return true' do
        subject.top_up(TOP_UP)
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end

      it 'raises a minimum balance error' do
        min_fare = 'Balance below minimum fare'
        expect { subject.touch_in(entry_station) }.to raise_error min_fare
      end

      it 'should record the entry station' do
        subject.top_up(TOP_UP)
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end

      it 'should store a complete journey' do
        subject.top_up(TOP_UP)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journey).to include journey
      end
    end

    describe '#touch_out' do
    
      it 'records the exit station' do
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq exit_station
      end

      it 'should deduct min fare from my card' do
        subject.top_up(TOP_UP)
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end


    end
  end
end
