class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove  :picture
      t.string  :image_url
    end
  end
end
