class FrontendController < ApplicationController
  include ApplicationHelper
  
  def home 
    @my_email = Setting.get_setting_by_title("s3528350@student.rmit.edu.au")
    @my_name = Setting.get_setting_by_title("Syed Sabih Ali")
    @attempt_grade_level = Setting.get_setting_by_title("Credit")
    @tutor_group = Setting.get_setting_by_title("Group 8 Mon 8:30am - Matt")
    @student_number = Setting.get_setting_by_title("s3528350")
  end
  
  def zone_json
    
  end
  
  def calculate_local_time
    @result = helpers.calculate_local_time(params["time_zone"].to_s, params["clock_type"].to_s)  
    render :layout => false
  end
  
end
