class Setting < ApplicationRecord
  
  def self.get_setting_by_title(title)
    @value = ""
    @setting = Setting.where(:title => title).first
    if @setting != nil then 
      @value = @setting.value  
    end
    return @value
  end
  
  def self.create_setting(title, value)
    @setting = Setting.find_by_title(title)
    if @setting == nil then 
      @max = Setting.maximum("id")
      @new_setting = Setting.new 
      @new_setting.title = title.to_s
      @new_setting.value = value
      @new_setting.id = @max.to_i + 1
      @new_setting.save!
      puts "Setting " + title.to_s + " was created."  
    else 
      @setting.value = value
      @setting.save!
      puts "Setting " + title.to_s + " was found."
    end  
  end
  
end
