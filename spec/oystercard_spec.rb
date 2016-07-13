require "oystercard"

describe Oystercard do

  subject(:card) { described_class.new }
  random_number = rand(1...Oystercard::LIMIT)
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exist_station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  it 'Has a default balance of 0' do
    expect(card.balance).to eq 0
  end

  it "Can be topped up" do
    expect{ card.top_up(random_number) }.to change{ card.balance }.by random_number
  end


  it "Raises error when top up exceeds limit" do
    card.top_up(Oystercard::LIMIT)
    error = "Top up would exceed card limit of £#{Oystercard::LIMIT}"
    expect{ card.top_up(1) }.to raise_error error
  end


  describe "#touch_in(entry_station)" do
    it "Raises an error when insufficient blance" do
      msg = 'Insufficient balance'
      expect{ card.touch_in(entry_station) }.to raise_error msg
    end

    context do
      before(:each) {
                      card.top_up(Oystercard::MIN_BALANCE)
                      card.touch_in(entry_station)
                    }
      it "Can be touched in when at least minimum balance available" do
        expect(card.in_journey?).to eq true
      end

      it "Remembers its entry_station" do
        expect(card.entry_station).to eq entry_station
      end
    end




  end



  it {is_expected.to respond_to(:touch_out).with(1).arguments}

  describe "#touch_out" do

    before(:each) {
                    card.top_up(Oystercard::MIN_BALANCE)
                    card.touch_in(entry_station)
                  }

    it "remembers exit station" do
      card.touch_out(exit_station)
      expect(card.exit_station).to eq exit_station
    end

    it "Deduct the fare from the card" do
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by -Oystercard::MIN_BALANCE
    end

    it "Forgets the entry_station" do
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

  end

  it "has an empty list of journeys by default" do
    expect(card.journeys).to be_empty
  end

  it "saves a journey" do
    card.top_up(20)
    card.touch_in(entry_station)
    card.touch_out(exit_station)
    expect(card.journeys).to include journey
  end



  it "Knows that the card is not travelling if it hasn't been used yet" do
    expect(card).to_not be_in_journey
  end

  context "Knows that the card is" do

    before(:each) { card.top_up(7) }
    it "travelling" do
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it "not travelling if it's touched out" do
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).to_not be_in_journey
    end
  end
end
