
class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
    @in_journey = true
  end

  def finished_journey(exit_station = nil)
    @exit_station = exit_station
    @complete = true
    @in_journey = false
  end

  def fare
    (entry_station == nil || exit_station == nil) ? PENALTY_FARE : MINIMUM_FARE

  end

  def in_journey?
    @in_journey
  end

  def complete?
    @complete
  end

end
