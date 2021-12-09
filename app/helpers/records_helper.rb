module RecordsHelper
  def sum_day_record(records)
    hour = 0
    minute = 0
    records.each do |record|
      hour += record.hour
      minute += record.minute
    end
    hour += minute.to_f / 60
    # hour.round(1)
  end

  def week_record(user_record)
    # 範囲0~6日前
    range = 0..6
    for num in range do
      # dateはnum日前
      date = Date.today - num
      # num日前のrecords
      records = user_record.where(date: date)
      ja_date = date.month.to_s + "/" + date.day.to_s + "(" + %w(日 月 火 水 木 金 土)[date.wday] + ")"
      # num日前の学習時間の合計を導出
      if records.size == 0
        data = [ja_date, 0]
      else
        data = [ja_date, sum_day_record(records)]
      end

      case num
      when 0
        datas = data
      when 1
        datas = [data, datas]
      else
        datas.unshift(data)
      end
    end
    datas
  end

  def sum_week_record(user_record)
    records = week_record(user_record)
    range = 0..6
    sum_record = 0
    for num in range do
      sum_record += records[num][1]
    end
    sum_record
  end

  def show_hours_and_minutes(time)
    hours = time.floor
    minutes = ((time - hours) * 60).round
    hours.to_s + "時間" + minutes.to_s + "分"
  end
end
