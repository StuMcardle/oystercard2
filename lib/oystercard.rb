class Oystercard

  attr_reader :balance, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if (balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(station)
    fail "Insufficent balance" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end
end