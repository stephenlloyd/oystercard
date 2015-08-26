require 'oyster_card'
describe OysterCard do
  let(:station){double(:station)}
  let(:journey){double :journey, fare: 5, complete?: true}
  let(:journey_log){double :journey_log, all: [journey], stop: journey}
  let(:subject) {described_class.new(journey_log: journey_log)}

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

  it "has an empty journey log" do
    expect(subject.journeys).to eq journey_log
  end

  context 'it has a full balance' do
    before{subject.top_up(OysterCard::BALANCE_LIMIT)}

    it "won't let you top up over the balance limit" do
      expect{subject.top_up(1)}.to raise_error("You have exceeded your #{OysterCard::BALANCE_LIMIT} allowance.")
    end

    it "knows what station in touched in at" do
      expect(journey_log).to receive(:start).with(station)
      subject.touch_in(station)
    end

    it "records a journey with a No Station entry station when touching out without an entry station" do
      expect(journey_log).to receive(:stop).with(station)
      subject.touch_out(station)
    end

    context 'when touched in' do

      it "deducts the minimum charge from the balance when touching out" do
        expect{subject.touch_out(station)}.to change{subject.balance}.by(-journey.fare)
      end

    end

  end
end