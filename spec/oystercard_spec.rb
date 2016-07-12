require 'oystercard'
describe Oystercard do
  it 'initializes the Oystercard with a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  context "#top_up" do
    it "adds a value to the balance" do
      expect { subject.top_up(50) }.to change{ subject.balance }.by 50
    end

    it 'retricts top-ups to the maximum balance allowed' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  let (:station) {double :station}
  context "checking and updating card status (in use or not)" do
    it 'checks card touch in works' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end
    it "specifies entry station at touch_in" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'updates card status to "In use" when touching in' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.card_status).to eq "In use"
    end
    it "raises an error on touch in when balance is less than 1" do
      subject.top_up(0.1)
      expect{ subject.touch_in(station) }.to raise_error("Not enough funds")
    end

    it 'checks card touch out works' do
      expect(subject).to respond_to(:touch_out)
    end
    it 'removes entry_station at touch_out' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
    it 'deducts the fare from balance on touch out' do
      expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MIN_FARE
    end
    it 'updates card status to "Not in use" when touching out' do
      subject.touch_out
      expect(subject.card_status).to eq "Not in use"
    end
    it 'reveals the status of the card as being in use' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    
  end

end
