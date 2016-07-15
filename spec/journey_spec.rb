require 'journey'

describe Journey do
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  let (:journey) {described_class.new(entry_station)}


  it 'should record the begining of the journey' do
   expect(journey.entry_station).to eq entry_station

  end

  it 'should record the end of the journey' do
    journey.finished_journey(exit_station)
  expect(journey.exit_station).to eq exit_station
  end

  it 'should know if the journey is complete' do
    journey.finished_journey(exit_station)
    expect(journey.complete?).to eq true

  end

  it 'should know it the user is in journey' do
    expect(journey.in_journey?).to eq true
  end

  it 'should be able to calculate the journey fare, if journey is complete' do
    journey.finished_journey(exit_station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'should charge the penalty fare, it joruney is not complete' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
end
