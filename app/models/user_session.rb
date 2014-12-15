class UserSession
	include ActiveModel::Model
	attr_accessor :login, :senha
	validates_presence_of :login, :senha

	def initialize(session, attributes={})
		@session = session
		@login = attributes[:login]
		@senha = attributes[:senha]
	end

	def authenticate!
		user = User.authenticate(@login, @senha)

		if user.present?
			store(user)
		else
			errors.add(:base, :invalid_login)
			false
		end
	end

	def destroy
		@session[:user_id] = nil
	end

	def store(user)
		@session[:user_id] = user.id
	end

	def current_user
		User.find(@session[:user_id])
	end
	
	def user_signed_in?
		@session[:user_id].present?
	end

	def current_user?(user)
		if @session[:user_id] == user.id
			true
		end
	end
	
end