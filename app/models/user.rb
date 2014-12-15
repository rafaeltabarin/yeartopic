class User < ActiveRecord::Base 
		extend FriendlyId
		
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	validates_presence_of :nome

	validates_presence_of :login, :senha, :nome, :cidade, :estado, :email, :descricao
	validates_confirmation_of :senha
	validates_length_of :descricao, allow_blank: false
	validates_uniqueness_of :email
	validates :login, :uniqueness => true

	scope :confirmed, -> { where.not(login: nil) }
	scope :most_recent, -> { order('created_at DESC') }

	validate do
		errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	end

	def complete_name
		"#{nome}"
	end

	def self.authenticate(login, senha)
		user = confirmed.find_by(login: login, senha: senha)
		if user.present?
			user
		end
	end

	def self.search(query)
		if query.present?
			where(['nome ILIKE :query', query: "%#{query}%"])
		else
			all
		end
	end

	def to_param
		"#{id}-#{nome.parameterize}"
	end

end
