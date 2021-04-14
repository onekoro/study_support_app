module RecordsHelper
  def sum_record(records)
    hour = 0
    minute = 0
    records.each do |record|
      hour += record.hour
      minute += record.minute
    end
    hour += minute.to_f / 60
    return hour.round(1)
  end
end
