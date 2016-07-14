class Journey
  attr_reader :entry_station, :exit_station, :station
  def initialize

  end
  def start(entry_station)
    self.entry_station = entry_station
    self.station = entry_station
  end
  def finish(exit_station)
    self.exit_station = exit_station
    self.station = nil
  end
  def calculate_fare
  end

  def in_journey?
    self.station != nil
  end
  def complete?
  end

  private
  attr_writer :entry_station, :exit_station, :station


end
