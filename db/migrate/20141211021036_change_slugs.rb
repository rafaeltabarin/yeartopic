class ChangeSlugs < ActiveRecord::Migration
	def change
		remove_index :users, :slug
		add_index :users, :slug, unique: true
	end
end