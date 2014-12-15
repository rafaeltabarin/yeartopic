class UserCollectionPresenter
	delegate :current_page, :num_pages, :limit_value, :total_pages,
	to: :@users

	def initialize(users, context)
		@users = users
		@context = context
	end

	def to_ary
		@users.map do |user|
			UserPresenter.new(user, @context, false)
		end
	end
end