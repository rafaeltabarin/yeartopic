class UserPresenter

	delegate :id, :user, :created_at, :descricao, :nome, :login, 
				:senha, :cidade, :estado, :email, :image, :to_param, to: :@user

	def self.model_name
		User.model_name
	end
	
	def initialize(user, context, show_form=true)
		@context = context
		@user = user
		@show_form = show_form
	end

	def can_review?
		@context.user_signed_in?
	end

	def show_form?
		@show_form
	end

	def review
		@review ||= @user.reviews.
		find_or_initialize_by(user_id: @context.current_user.id)
	end

	def review_route
		[@user, review]
	end

	def route
		@user
	end

	def review_points
		Review::POINTS
	end
	# Faz com que a partial 'user' seja renderizada quando chamamos o 'render'
	# com o objeto da classe user presenter.
	def to_partial_path
		'user'
	end

	def image
		@user.image
	end
	end