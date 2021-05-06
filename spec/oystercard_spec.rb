require 'oystercard'

describe Oystercard do
  
  it 'checks that default balance is zero' do
    expect(subject.balance).to eq (0)
  end

  it 'can add to the balance' do
    #subject.top_up(5)
    #expect(subject.balance).to eq(5)
    expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
  end

  it 'raises error when balance is over 90' do
    expect{ subject.top_up(91) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
  end

  it 'can deduct from the balance' do
    expect{ subject.deduct(5) }.to change{ subject.balance }.by -5
  end

  it 'touches in' do
    station = double("station")
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in(station)
    expect(subject.in_journey?).to eq (true)
  end

  it 'raises an error when touching in with insufficient balance' do
    station = double("station")
    expect{ subject.touch_in(station) }.to raise_error "Insufficent balance"
  end

  it 'touches out' do
    station = double("station")
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.in_journey?).to eq (false)
  end

  it 'logs the entry station' do
    station = double("station")
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'forgets entry station on touch out' do
    station = double("station")
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to eq([])
  end

  it 'stores a journey when touching in then touching out' do
    station = double("station")
    station2 = double("station")
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journeys).to eq([{entry_station: station, exit_station: station2}])
  end
end
