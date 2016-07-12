require 'oystercard'

describe Oystercard do
  it "checks balance" do
    expect(subject.balance).to eq 0
  end
  it "tops up money in the existing balance" do
    expect { subject.top_up(20) }.to change {subject.balance}.by 20
  end
end
