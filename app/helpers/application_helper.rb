module ApplicationHelper
  def time_to_utc(local_date)
    time = "2023-05-18 13:30"
    date, time = local_date.split(" ")
    year, month, day = date.split("-")
    hour, min = time.split(":")
    
    DateTime.new(year, month, day,hour, min, 0 ,'-4')
  end
end
