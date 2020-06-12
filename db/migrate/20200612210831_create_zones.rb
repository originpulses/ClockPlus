class CreateZones < ActiveRecord::Migration[5.2]
  def change
    if table_exists? :zones then 
    else
      create_table :zones do |t|
        t.string :value 
        t.string :abbr
        t.integer :offset
        t.boolean :isdst
        t.string :text
        t.text :utc
        t.timestamps
      end
    end
  end
end
