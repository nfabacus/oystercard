require 'station'

describe Station do
  subject { described_class.new("London", 1) }

  it 'Should equal name' do
    expect(subject.name).to eq "London"
  end

  it 'Should equal zone' do
    expect(subject.zone).to eq 1
  end
end
