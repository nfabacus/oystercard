require 'journey'

describe Journey do
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  it "starts a journey" do
    subject.start(entry_station)
    expect(subject).not_to be_complete
  end
  it 'finishes a journey' do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject).to be_complete
  end
  it "remembers entry station" do
    subject.start(entry_station)
    expect(subject.entry_station).to eq entry_station
  end
  it "remembers exit station" do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject.exit_station).to eq exit_station
  end


end
