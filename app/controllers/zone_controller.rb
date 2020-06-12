class ZoneController < ApplicationController
  
  def search_zones
      
  end
  
  def search_zone_values
    @values = Zone.search_zone_values(params)
  end
  
end
