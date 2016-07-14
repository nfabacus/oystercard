require 'journey'
describe Journey do
  let(:station) {double :station}
  let(:card) {double :card}
  it "stores entry station" do
    expect{ subject.start(station) }.to change{ subject.entry_station }.from(nil).to(station)
  end
  it "stores exit station" do
    expect{ subject.finish(station) }.to change{ subject.exit_station }.from(nil).to(station)
  end
  it 'should not be in journey when initiated' do
    expect(subject).not_to be_in_journey
  end

end
