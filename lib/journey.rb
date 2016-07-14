class Journey

  MINIMUM_FARE = 1
  DEFAULT_PENALTY = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    self.complete = false
    self.in_journey = true
    self.entry_station = entry_station
  end

  def complete?
    @complete
  end

  def in_journey?
    @in_journey
  end

  def finish(exit_station = nil)
    self.exit_station = exit_station
    self.in_journey = false
    self.complete = true
  end

  def fare
    return MINIMUM_FARE if !entry_station && !exit_station || both_exist?
    DEFAULT_PENALTY
  end

  private

  attr_writer :complete, :entry_station, :in_journey, :exit_station

  def both_exist?
    entry_station != nil && exit_station != nil
  end

end
