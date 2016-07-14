class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station: entry_station)
    self.entry_station = entry_station
    self.complete = false
    self.in_journey = true
  end

  def complete?
    @complete
  end

  def in_journey?
    @in_journey
  end

  def finish(exit_station)
    self.exit_station = exit_station
    self.in_journey = false
    self.complete = true
  end

  private
  attr_writer :complete, :entry_station, :in_journey, :exit_station
end
