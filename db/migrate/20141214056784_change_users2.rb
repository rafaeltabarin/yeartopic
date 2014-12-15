class ChangeUsers2 < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove  :image_url
      t.string  :image_file_name
    end
  end
end
