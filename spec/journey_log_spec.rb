require 'journey_log'

describe JourneyLog do

  let(:journey){ double :journey, entry_station: nil }
  let(:station){ double :station }

  describe '#start' do
    it 'starts a journey' do
      expect(Journey).to receive(:new).with(entry_station: station)
      subject.start(station)
    end

    it 'records a journey' do
      allow(Journey).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.all).to include journey
    end
  end

  it 'stops a current journey' do
    allow(Journey).to receive(:new).and_return journey
    subject.start(station)
    expect(journey).to receive(:exit_station=).with(station)
    subject.stop(station)
  end

  it 'creates a journey if there is no current journey' do
    expect(Journey).to receive(:new).with(exit_station: station)
    subject.stop(station)
  end



end