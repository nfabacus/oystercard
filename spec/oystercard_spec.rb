require "oystercard"

describe Oystercard do

  subject(:card) { Oystercard.new }
  random_number = rand(Oystercard::LIMIT)

  it 'Has a default balance of 0' do
    expect(card.balance).to eq 0
  end

  it "Can be topped up" do
    expect{ card.top_up(random_number) }.to change{ card.balance }.by random_number
  end


  context do
    before(:each) { card.top_up(Oystercard::LIMIT) }

    it "Raises error when top up exceeds limit" do
      error = "Top up would exceed card limit of £#{Oystercard::LIMIT}"
      expect{ card.top_up(1) }.to raise_error error
    end

    it "Deduct the fare from the card" do
      expect{ card.deduct(random_number) }.to change{ card.balance }.by -random_number
    end
  end


  it "Raises an error when insufficient blance" do
    msg = 'Insufficient balance'
    expect{ card.touch_in }.to raise_error msg
  end


  it "Can be touched in" do
    card.top_up(1)
    expect(card.touch_in).to eq true
  end


  it "Can be touched out" do
    expect(card.touch_out).to eq false
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
