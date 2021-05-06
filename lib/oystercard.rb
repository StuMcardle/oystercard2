class Oystercard

  attr_reader :balance, :entry_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
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

  def touch_out(station)
    add_journey(station)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def add_journey(station)
    @journeys << {entry_station: @entry_station, exit_station: station}
  end
end
