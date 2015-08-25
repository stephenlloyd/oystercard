require 'journey'

describe Journey do

  it { is_expected.to respond_to(:entry_station)}
  it { is_expected.to respond_to(:entry_station=)}
  it { is_expected.to respond_to(:exit_station)}
  it { is_expected.to respond_to(:exit_station=)}

  it 'can be initialized with an entry station' do
    journey = described_class.new(entry_station: :station)
    expect(journey.entry_station).to eq :station
  end

  it 'can be initialized with an exit station' do
    journey = described_class.new(exit_station: :station)
    expect(journey.exit_station).to eq :station
  end

  it 'returns a fare' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

end