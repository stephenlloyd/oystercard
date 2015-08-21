require 'oyster_card'
describe OysterCard do
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

  context 'it has a 90 balance' do
    before{subject.top_up(90)}

    it "won't let you top up over 90" do
      expect{subject.top_up(1)}.to raise_error("You have exceeded your 90 allowance.")
    end

    it "can deduct an amout" do
      expect{subject.deduct(5)}.to change{subject.balance}.by(-5)
    end



  end
end