class Oystercard

  attr_reader :balance, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if exceed_maximum_balance?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in(entry_station)
    fail "Insufficent balance" if below_min_balance?
    @current_journey ? replace_journey(entry_station) : new_journey(entry_station)
  end

  def touch_out(exit_station)
    @current_journey ? finish_journey(exit_station) : finish_incomplete_journey(exit_station)
  end

  def in_journey?
    !@current_journey.nil?
  end

  private

  def exceed_maximum_balance?(amount)
    (balance + amount) > MAXIMUM_BALANCE
  end

  def below_min_balance?
    balance < MINIMUM_BALANCE
  end

  def add_journey
    @journeys << @current_journey
  end

  def replace_journey(entry_station)
    add_journey
    new_journey(entry_station)
  end
  
  def new_journey(entry_station = nil)
    @current_journey = Journey.new(entry_station)
  end

  def finish_journey(exit_station)
    @current_journey.finish(exit_station)
    add_journey
    @current_journey = nil
  end

  def finish_incomplete_journey(exit_station)
    @current_journey = Journey.new
    finish_journey(exit_station)
  end
end
