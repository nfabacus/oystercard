require 'station'

describe Station do


  let(:name)        { double :name }
  let(:zone)        { double :zone }
  subject(:station) { described_class.new(name, zone) }


  it "Knows its name" do
    expect(station.name).to eq name
  end

  it "Know its zone" do
    expect(station.zone).to eq zone
  end

end
