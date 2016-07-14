require 'journey'
describe Journey do

  default_penalty = 6
  let(:station) {double :station, zone: 1}
  let(:exit_station) {double :exit_station}

  subject{ described_class.new(station) }

  context "On initialization" do
    it { is_expected.not_to be_complete }

    it "default penalty should be #{default_penalty}" do
      expect(Journey::DEFAULT_PENALTY).to eq default_penalty
    end
  end

  context "On start" do

    it "should set entry station" do
      expect(subject.entry_station).to eq station
    end

    it { is_expected.to be_in_journey }

    context "On finish" do
      before do
        subject.finish(exit_station)
      end

      it "should set exit station" do
        expect(subject.exit_station).to eq exit_station
      end

      it { is_expected.not_to be_in_journey }

      it { is_expected.to be_complete }

      it 'applies fare' do
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end

    end
  end

  context 'When departure or arrival station is NOT provided' do
    let(:journey){ Journey.new }

    it "returns the default fare for the moment" do
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    context 'Apply penalty if' do
      it 'not touched in' do
        journey.finish(exit_station)
        expect(journey.fare).to eq Journey::DEFAULT_PENALTY
      end

      it 'not touched out' do
        expect(subject.fare).to eq Journey::DEFAULT_PENALTY
      end
    end

  end

end
