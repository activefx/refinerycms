# require 'devise'
#require 'actor'

class User < Actor

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :username, :plugins, :login

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable

  class << self
    # Find user by email or username.
    # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
    def find_for_database_authentication(conditions)
      login = conditions.delete(:login)
      self.any_of({ :username => login }, { :email => login }).first
    end

    def find_by_email(email)
      where(:email => email).first
    end

    def find_by_reset_password_token(reset_password_token)
      where(:reset_password_token => reset_password_token).first
    end
  end

end

