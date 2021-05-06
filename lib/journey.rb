class Journey
  DEFAULT_PENALTY_FARE = 6

  attr_reader :fare, :entry_station, :exit_station

  def initialize(entry_station = nil)
    @complete = false
    @fare = DEFAULT_PENALTY_FARE
    @entry_station = entry_station
  end

  def finish(exit_station)
    @complete = true
    @fare = 1 if @entry_station
    @exit_station = exit_station
  end

  def complete?
    @complete
  end

end
