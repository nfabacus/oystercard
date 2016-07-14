require 'journey'
describe Journey do
  let(:station) {double :station, zone: 1}
  let(:exit_station) {double :exit_station}
  subject {described_class.new(entry_station: station)}

  context "on initialization" do

    it { is_expected.not_to be_complete }

    it "should be set entry_station" do
      expect(subject.entry_station).to eq station
    end

    it { is_expected.to be_in_journey }
  end

  context "on finish" do

    before do
      subject.finish(exit_station)
    end

    it "should be set exit_station" do
      expect(subject.exit_station).to eq exit_station
    end

    it { is_expected.not_to be_in_journey }
    
    it { is_expected.to be_complete }

  end


end
