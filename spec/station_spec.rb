require 'station'

describe Station do

  let(:entry_station) { double(:entry_station) }
  let(:zone) { double(:zone) }

  subject { described_class.new(entry_station, zone) }

  context 'On initialization' do

    it 'Should equal name' do
      expect(subject.name).to eq entry_station
    end

    it 'Should equal zone' do
      expect(subject.zone).to eq zone
    end

  end

end
