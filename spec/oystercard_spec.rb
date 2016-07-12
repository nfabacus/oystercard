require 'oystercard'

describe Oystercard do
  it "checks balance" do
    expect(subject.balance).to eq 0
  end
end
