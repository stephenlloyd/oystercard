require 'journey_log'

describe JourneyLog do

  let(:journey){ double :journey, entry_station: nil, complete?: false }
  let(:station){ double :station }

  before do
    allow(Journey).to receive(:new).and_return journey
  end

  describe '#start' do
    it 'starts a journey' do
      expect(Journey).to receive(:new).with(entry_station: station)
      subject.start(station)
    end

    it 'records a journey' do
      allow(Journey).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.journeys).to include journey
    end
  end

  it 'stops a current journey' do
    allow(Journey).to receive(:new).and_return journey
    subject.start(station)
    expect(journey).to receive(:exit_station=).with(station)
    subject.stop(station)
  end

  it 'creates a journey if there is no current journey' do
    expect(Journey).to receive(:new).and_return(journey)
    allow(journey).to receive(:exit_station=).with(station)
    subject.stop(station)
  end

  it "returns a new journey when stopping when no current journeys" do
    allow(Journey).to receive(:new).and_return journey
    allow(journey).to receive(:exit_station=).with(station)
    expect(subject.stop(station)).to eq journey
  end

  it "returns an open journey when stopping" do
    allow(subject).to receive(:journeys).and_return([journey])
    allow(journey).to receive(:exit_station=)
    expect(subject.stop(station)).to eq journey
  end

  it "wont let you start a new journey if there is a current journey" do
    allow(journey).to receive(:entry_station).and_return(station)
    expect{subject.start(station)}.to raise_error("Already in a Journey.")
  end

end