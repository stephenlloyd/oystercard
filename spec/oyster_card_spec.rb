require 'oyster_card'
describe OysterCard do
  let(:station){double(:station)}
  let(:journey){double :journey, fare: 5}
  let(:journey_class) {double :journey_class, new: journey}
  let(:subject) {described_class.new(journey: journey_class)}

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it "can top up the balance" do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it "can't deduct if the balance goes below zero" do
    expect{subject.touch_in(station)}.to raise_error("You don't have enough.")
  end

  it "won't let you touch in if you don't have enough balance" do
    expect{subject.touch_in(station)}.to raise_error("You don't have enough.")
  end

  it "has an empty journey history" do
    expect(subject.journeys).to be_empty
  end

  context 'it has a full balance' do
    before{subject.top_up(OysterCard::BALANCE_LIMIT)}

    it "won't let you top up over the balance limit" do
      expect{subject.top_up(1)}.to raise_error("You have exceeded your #{OysterCard::BALANCE_LIMIT} allowance.")
    end

    it "knows what station in touched in at" do
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it "records a journey with a No Station entry station when touching out without an entry station" do
      expect(journey).to receive(:exit_station=).with(station)
      subject.touch_out(station)
    end

    it "records the journey when touching in" do
      subject.touch_in(Station)
      expect(subject.journeys).to include(journey)
    end

    it "creates a new journey when touching in" do
      expect(journey_class).to receive(:new).with({entry_station: station, exit_station: nil})
      subject.touch_in(station)
    end

    context 'when touched in' do
      before do
        subject.touch_in(station)
        allow(journey).to receive(:exit_station=)
      end

      it "cannot touch in again" do
        expect{subject.touch_in(station)}.to raise_error("Already touched in.")
      end

      it "deducts the minimum charge from the balance when touching out" do
        expect{subject.touch_out(station)}.to change{subject.balance}.by(-journey.fare)
      end

      it "records the journey on touch out" do
        expect(journey).to receive(:exit_station=).with(station)
        subject.touch_out(station)
      end

    end

  end
end