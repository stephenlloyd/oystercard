require 'oyster_card'
describe OysterCard do
  let(:station){double(:station)}
  let(:other_station){double :other_station}
  let(:journey){double :journey, fare: 10}
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
    expect{subject.deduct(1)}.to raise_error("You don't have enough.")
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

    it "can deduct an amout" do
      expect{subject.deduct(5)}.to change{subject.balance}.by(-5)
    end

    it "knows if it's not in a journey" do
      expect(subject.in_journey?).to be(false)
    end

    it "knows if it's in a journey" do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "knows what station in touched in at" do
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it "records a journey with a No Station entry station when touching out without an entry station" do
      expect(journey_class).to receive(:new).with({entry_station: nil, exit_station: station})
      subject.touch_out(station)
    end


    context 'when touched in' do
      before{subject.touch_in(station)}

      it "can touch out of a journey" do
        subject.touch_out(other_station)
        expect(subject).not_to be_in_journey
      end

      it "deducts the minimum charge from the balance when touching out" do
        expect{subject.touch_out(other_station)}.to change{subject.balance}.by(-OysterCard::MINIMUM_CHARGE)
      end

      it "records the journey on touch out" do
        expect(journey_class).to receive(:new).with({entry_station: station, exit_station: other_station})
        subject.touch_out(other_station)
      end

    end

  end
end