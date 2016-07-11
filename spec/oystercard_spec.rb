require 'oystercard'
describe Oystercard do
  it 'initializes the Oystercard with a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  context "#top_up" do
    it "adds a value to the balance" do
      expect { subject.top_up(50) }.to change{ subject.balance }.by 50
    end


  end

end
