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
      # expect {subject.top_up(91)}.to raise_error "Maximum balance exceeded"
      # or
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  context "pay fares" do
    it 'deducts fares from balance on Oystercard' do
      expect{ subject.deduct(10)}.to change{ subject.balance }.by -10
    end
  end

end
