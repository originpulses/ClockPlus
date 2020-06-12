module ApplicationHelper

  def convert_big_hour_to_small_hour(hour)
    @hour = hour.to_i 
    if @hour == 13 then @hour = "01" end  
    if @hour == 14 then @hour = "02" end
    if @hour == 15 then @hour = "03" end
    if @hour == 16 then @hour = "04" end  
    if @hour == 17 then @hour = "05" end
    if @hour == 18 then @hour = "06" end
    if @hour == 19 then @hour = "07" end  
    if @hour == 20 then @hour = "08" end
    if @hour == 21 then @hour = "09" end
    if @hour == 22 then @hour = "10" end  
    if @hour == 23 then @hour = "11" end
    if @hour == 24 then @hour = "12" end
    return @hour.to_s
  end
  
  def calculate_local_time(timezone_string, clock_type)
     Time.zone = timezone_string
     @time_now = Time.now.in_time_zone.to_s 
     @current_hour = @time_now[10..15]
     if clock_type == "12 hours" then 
       @hour = @current_hour[1..2].to_s
       puts "Hour for " + timezone_string.to_s + " is: " + @hour.to_s
       if @hour.to_i >= 0 and @hour.to_i < 12 then @current_hour += " AM" end
       if @hour.to_i > 12 then @current_hour = convert_big_hour_to_small_hour(@hour.to_i) + @current_hour[3..5].to_s + " PM" end 
     end
     return @current_hour
  end
  
  def calculate_time_mode(timezone_string)
     Time.zone = timezone_string
     @time_now = Time.now.in_time_zone.to_s 
     @current_date = Date.parse(@time_now[0..9].to_s)    
     @offset = @time_now.to_s[20..22] + ":" + @time_now.to_s[23..24]
     @current_year = @time_now.to_s[0..3]
     @current_month = @time_now.to_s[5..6]
     @current_day = @time_now.to_s[8..9]
     @current_hour = @time_now.to_s[11..12]
     @current_minute = @time_now.to_s[14..15]
     @current_second = @time_now.to_s[17..18]
     @start_business_time = Time.new(@current_year, @current_month, @current_day, 9, 0, 0, @offset)
     @end_business_time = Time.new(@current_year, @current_month, @current_day, 17, 59, 59, @offset)
     
     @start_business_overtime = Time.new(@current_year, @current_month, @current_day, 18, 0, 0, @offset) 
     @end_business_overtime = Time.new(@current_year, @current_month, @current_day, 19, 59, 59, @offset) 
     
     @start_person_time1 = Time.new(@current_year, @current_month, @current_day, 20, 0, 0, @offset)
     @end_person_time1 = Time.new(@current_year, @current_month, @current_day, 22, 59, 59, @offset)
     
     @start_person_time2 = Time.new(@current_year, @current_month, @current_day, 8, 0, 0, @offset)
     @end_person_time2 = Time.new(@current_year, @current_month, @current_day, 8, 59, 59, @offset)
     
     @start_sleep_time1 = Time.new(@current_year, @current_month, @current_day, 23, 0, 0, @offset)
     @end_sleep_time1 = Time.new(@current_year, @current_month, @current_day, 23, 59, 59, @offset)
     
     @start_sleep_time2 = Time.new(@current_year, @current_month, @current_day, 0, 0, 0, @offset)
     @end_sleep_time2 = Time.new(@current_year, @current_month, @current_day, 7, 59, 59, @offset)
     
     @mode = "Unknown"
     
     if @start_business_time <= @time_now and @time_now <= @end_business_time then 
       @mode = "business"
     elsif @start_business_overtime <= @time_now and @time_now <= @end_business_overtime then 
       @mode = "business_overtime"
     elsif @start_person_time1 <= @time_now and @time_now <= @end_person_time1 then
       @mode = "personal_time" 
     elsif @start_person_time2 <= @time_now and @time_now <= @end_person_time2 then
       @mode = "personal_time" 
     elsif @start_sleep_time1 <= @time_now and @time_now <= @end_sleep_time1 then
       @mode = "sleeping_time"  
     elsif @start_sleep_time2 <= @time_now and @time_now <= @end_sleep_time2 then
       @mode = "sleeping_time"  
     end
#      puts "Mode is: " + @mode.to_s
     return @mode
  end
  
  def calculate_day_difference(timezone1, timezone2)
    Time.zone = timezone1
    @time1_now = Time.now.in_time_zone.to_s 
    Time.zone = timezone2
    @time2_now = Time.now.in_time_zone.to_s 
    @date1 = Date.parse(@time1_now.to_s[0..9])
    @date2 = Date.parse(@time2_now.to_s[0..9]) 
    puts @date1.to_s
    puts @date2.to_s
    @difference = @date1 - @date2
    return @difference.to_i
  end
  
  def convert_day_difference_to_human(difference)
    @difference = difference.to_s 
    if @difference == "0" then 
      @result = "today"
    elsif @difference == "1" then 
      @result = "yesterday"
    elsif @difference == "-1" then 
      @result = "tomorrow"
    end
    return @result
  end
  
  def calculate_date_difference_to_human(timezone1, timezone2)
     @day_difference = calculate_day_difference(timezone1, timezone2)  
     return convert_day_difference_to_human(@day_difference)
  end
  
  def calculate_offset_difference_in_hours(timezone1, timezone2)
    Time.zone = timezone1
    @time1_now = Time.now.in_time_zone.to_s 
    Time.zone = timezone2
    @time2_now = Time.now.in_time_zone.to_s   
    puts @time1_now.to_s
    @offset1 = @time1_now.to_s[20..22] + ":" + @time1_now.to_s[23..24]
    puts @offset1.to_s
    @offset2 = @time2_now.to_s[20..22] + ":" + @time2_now.to_s[23..24]
    puts @offset2.to_s
    
    @offset1_sign = @offset1[0].to_s
    if @offset1_sign == "-" then @offset1_sign = -1 else @offset1_sign = 1 end
    @offset1_integer = @offset1_sign * @offset1[1..2].to_i
    
    @offset2_sign = @offset2[0].to_s
    if @offset2_sign == "-" then @offset2_sign = -1 else @offset2_sign = 1 end
    @offset2_integer = @offset2_sign * @offset2[1..2].to_i  
      
    puts "Offsets: " +  @offset1_integer.to_s + " " + @offset2_integer.to_s
    @difference = @offset1_integer - @offset2_integer
    return @difference
  end
  
  def calculate_offset_difference_in_hours_and_human(timezone1, timezone2)
    @input = calculate_offset_difference_in_hours(timezone1, timezone2)
    if @input > 0 then @result = "+" + @input.to_s else @result = @input.to_s end 
    @result += "h"
    if @result == "0h" then @result = "" end
    return @result
  end
  
end


# 1.
#  Business time:
# 2.
#  Business overtime:
# 3.
#  Person time:
# 4.
#  Sleeping time:
# local time 9:00am – 5:59pm
# local time 6:00pm – 7:59pm
# local time: 8:00am – 8:59am, 8:00pm - 10:59pm
# local time: 11:00pm – 7:59am
