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

  describe '#fare' do

    let(:station) { double :station }
    let(:other_station) { double :other_station }

    it 'returns a fare' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'two stations' do
      before do
        subject.entry_station = station
        subject.exit_station = other_station
      end

      it 'calculate a fare for zone 1 to zone 1' do
        update_zones(1,1)
        expect(subject.fare).to eq 1
      end

      it 'calculate a fare for zone 1 to zone 2' do
        update_zones(1,2)
        expect(subject.fare).to eq 2
      end

      it 'calculate a fare for zone 6 to zone 5' do
        update_zones(6,5)
        expect(subject.fare).to eq 2
      end

      it 'calculate a fare for zone 6 to zone 1' do
        update_zones(6,2)
        expect(subject.fare).to eq 5
      end

      def update_zones(entry_zone, exit_zone)
        allow(station).to receive(:zone).and_return(entry_zone)
        allow(other_station).to receive(:zone).and_return(exit_zone)
      end
    end
  end


end