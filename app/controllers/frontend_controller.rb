class FrontendController < ApplicationController
  include ApplicationHelper
  
  def home 
    
    @my_email = Setting.get_setting_by_title("My email")
    @my_name = Setting.get_setting_by_title("My name")
    @attempt_grade_level = Setting.get_setting_by_title("Attempt grade level")
    @tutor_group = Setting.get_setting_by_title("Tutor group")
    @student_number = Setting.get_setting_by_title("Student number")
  end
  
  def zone_json
    
  end
  
  def calculate_local_time
    @result = helpers.calculate_local_time(params["time_zone"].to_s, params["clock_type"].to_s)  
    render :layout => false
  end
  
  
  
end
