require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it 'should check that a new card has a balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'should have default value of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it {is_expected.to respond_to(:top_up).with(1).argument}

    it "should add money to balance" do
      expect{subject.top_up(5)}.to change {subject.balance}.by 5
    end

    it "should throw an error, if balance is exceed limit" do
      limit = Oystercard::LIMIT
      expect { subject.top_up(91) }.to raise_error "Exceeds limit: #{limit}"
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'should have default value of false' do
      expect(subject.in_journey?).to eq (false)
    end
      end

   describe '#touch_in' do
       let(:station) {double :station}
      #it { is_expected.to respond_to(:touch_in) }

      it 'should return true' do
        subject.top_up(2)
        subject.touch_in(station)
       expect(subject).to be_in_journey
      end
        it 'raises a minimum balance error' do
         expect {subject.touch_in(station) }.to raise_error "Balance below minimum fare"
       end
       it 'should record the entry station' do
          subject.top_up(1)
          subject.touch_in(station)
          expect(subject.entry_station).to eq station
          #expect { is_expected.to respond_to(:touch_in).with(1).argument}
         #expect(subject.touch_in).with(1).argument
       end
   end


    describe '#touch_out' do
      let(:station) {double :station}
     it { is_expected.to respond_to(:touch_out) }

      it 'should return false' do
        expect(subject.touch_out).to be nil
     end

      it 'should deduct min fare from my card' do
        subject.top_up(1)
        subject.touch_in(station)
        expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end
    end

end
