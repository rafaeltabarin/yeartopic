class HomeController < ApplicationController
	def index
		@users = User.take(3)
	end
end