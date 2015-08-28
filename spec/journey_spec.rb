require 'journey'
describe Journey do
  it { is_expected.to respond_to(:entry_station)}
  it { is_expected.to respond_to(:exit_station)}
  it 'is created with an entry station' do
    subject = described_class.new(entry_station: :station)
    expect(subject.entry_station).to eq :station
  end

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  describe '#fare' do

    let(:station) { double :station, zone: 1 }
    let(:other_station) { double :other_station, zone: 1 }

    it 'has a penalty fare by default' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "returns itself when exiting a journey" do
      expect(subject.exit(station)).to eq(subject)
    end

    context 'given two stations' do
      subject {described_class.new(entry_station: station)}

      before do
        subject.exit(other_station)
      end

      it 'calculates a fare for zone 1 to zone 1' do
        update_zones(1,1)
        expect(subject.fare).to eq 1
      end

      it 'calculates a fare for zone 1 to zone 2' do
        update_zones(1,2)
        expect(subject.fare).to eq 2
      end

      it 'calculates a fare for zone 6 to zone 5' do
        update_zones(6,5)
        expect(subject.fare).to eq 2
      end

      it 'calculates a fare for zone 6 to zone 1' do
        update_zones(6,2)
        expect(subject.fare).to eq 5
      end

      it "knows if a journey is complete" do
        expect(subject).to be_complete
      end

      def update_zones(entry_zone, exit_zone)
        allow(station).to receive(:zone).and_return(entry_zone)
        allow(other_station).to receive(:zone).and_return(exit_zone)
      end

    end
  end
end