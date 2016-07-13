class Journey
  attr_reader :entry_station, :exit_station
  def start(entry_station)
    @complete = false
    @entry_station = entry_station
  end

  def complete?
    @complete
  end

  def finish(exit_station)
    @complete = true
    @exit_station = exit_station
  end
end
