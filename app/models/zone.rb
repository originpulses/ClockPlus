class Zone < ApplicationRecord
  
  def self.import_data_if_required
    @json_path = Rails.root.join("public", "zone.json")
    @count_zones = Zone.all.count 
    if @count_zones == 0 then 
      json_file = File.read(@json_path)
      parsed_json = JSON.parse(json_file)
      zones = []
      for @p in parsed_json do
        @value = @p["value"].to_s 
        @abbr = @p["abbr"].to_s 
        @offset = @p["offset"]
        @isdst = @p["isdst"]
        @text = @p["text"].to_s 
        @utc = @p["utc"]
        @new_zone = Zone.new 
        @new_zone.value = @value
        @new_zone.abbr = @abbr
        @new_zone.offset = @offset
        @new_zone.isdst = @isdst
        @new_zone.text = @text
        @new_zone.utc = @utc 
        zones << @new_zone
      end
      puts zones.size.to_s + " zones were added to db."
      Zone.import(zones)
    end
  end
  
  def self.search_zone_values(params)
    @search_term = params["search_term"].to_s
    if @search_term == "" then
      @values = []
    elsif @search_term == "all" then 
      @values = Zone.all.pluck(:value).to_a
    else
      @values = Zone.where("value like ?", "%" + @search_term + "%").pluck(:value).to_a  
    end
    return @values
  end
  
end
