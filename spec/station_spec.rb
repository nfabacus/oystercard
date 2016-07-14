require 'station'

describe Station do
  let(:name) { :name }
  let(:zone) { :zone }
  subject(:station) { described_class.new(name, zone) }

  it 'Should equal name' do
    expect(:name).to eq :name
  end

  it 'Should equal zone' do
    expect(:zone).to eq :zone
  end
end
