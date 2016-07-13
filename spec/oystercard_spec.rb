require "oystercard"

describe Oystercard do

  subject(:card) { described_class.new }
  random_number = rand(Oystercard::LIMIT)

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


  describe "#touch_in" do
    it "Raises an error when insufficient blance" do
      msg = 'Insufficient balance'
      expect{ card.touch_in }.to raise_error msg
    end

    it "Can be touched in when at least minimum balance available" do
      card.top_up(Oystercard::MIN_BALANCE)
      card.touch_in
      expect(card.in_journey?).to eq true
    end
  end




  describe "#touch_out" do

    it "Can be touched out" do
      card.top_up(Oystercard::MIN_BALANCE)
      card.touch_out
      expect(card.touch_out).to eq false
    end

    it "Deduct the fare from the card" do
      card.top_up(Oystercard::MIN_BALANCE)
      card.touch_in
      expect{ card.touch_out }.to change{ card.balance }.by -Oystercard::MIN_BALANCE
    end
  end





  it "Knows that the card is not travelling if it hasn't been used yet" do
    expect(card).to_not be_in_journey
  end

  context "Knows that the card is" do

    before(:each) { card.top_up(7) }
    it "travelling" do
      card.touch_in
      expect(card).to be_in_journey
    end

    it "not travelling if it's touched out" do
      card.touch_in
      card.touch_out
      expect(card).to_not be_in_journey
    end
  end
end
