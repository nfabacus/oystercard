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

  describe "#deduct" do
    it {is_expected.to respond_to(:deduct).with(1).argument}

    it "should deduct money from balance" do
      expect{subject.deduct(100)}.to change {subject.balance}.by -100
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) } 

    it 'should have default value of false' do
      expect(subject.in_journey?).to eq (false)
    end
  end

  context 'when user is in and out of journey' do
   describe '#touch_in' do
      it { is_expected.to respond_to(:touch_in) }

      it 'should return true' do
        subject.touch_in
       expect(subject).to be_in_journey
      end
   end

    describe '#touch_out' do
     it { is_expected.to respond_to(:touch_out) }

      it 'should return false' do
        expect(subject.touch_out).to be false
     end
    end
  end
end
