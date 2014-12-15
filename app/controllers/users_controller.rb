class UsersController < ApplicationController
	PER_PAGE = 10

	before_action :require_no_authentication, only: [:new, :create]
	before_action :require_authentication, only: [:show]
	before_action :can_change, only: [:edit, :update, :delete, :destroy]

	def index
		@search_query = params[:q]

		users = User.search(@search_query).
			page(params[:page]).
			per(PER_PAGE)
			@users = UserCollectionPresenter.new(users.most_recent, self)
	end

	def show
		user_model = User.find(params[:id])
		@user = UserPresenter.new(user_model, self)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to @user,
			notice: 'Cadastro criado com sucesso!'
		else
			render action: :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user,
			notice: 'Cadastro atualizado com sucesso!'
		else
			render action: :edit
		end
	end

	def delete
		@user = User.find(user_session.id)
	end

	def destroy
		@user = User.find(user_session.id)
		@user.destroy
		user_session.destroy
		redirect_to root_path, notice: t('flash.notice.destroy_user')
	end

	private

	def user_params
		# Os "pontos" no final da linha não são opcionais!
		params.
			require(:user).
			permit(:login, :senha, :senha_confirmation, :nome,
					:cidade, :estado, :email, :descricao, :image)
	end

	def can_change
		unless user_signed_in? && current_user == user
			redirect_to user_path(params[:id])
		end
	end

	def user
		@user ||= User.find(params[:id])
	end
end
