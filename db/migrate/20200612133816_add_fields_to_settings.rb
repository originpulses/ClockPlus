class AddFieldsToSettings < ActiveRecord::Migration[5.2]
  def change
    if column_exists? :settings, :title then       
    else
      add_column :settings, :title, :string
    end
    if column_exists? :settings, :value then       
    else
      add_column :settings, :value, :text
    end
    
  end
end
