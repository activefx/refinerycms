require 'devise'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  # Model Fields
  field :username,              :type => String,  :default => ""
  # Devise Confirmable
  field :confirmation_token,    :type => String
  field :confirmed_at,          :type => Time
  field :confirmation_sent_at,  :type => Time
  # Devise Database Authenticable
  field :email,                 :type => String,  :default => ""
  field :encrypted_password,    :type => String,  :default => ""
  # Devise Encryptable
  field :password_salt,         :type => String,  :default => ""
  # Devise Lockable
  field :failed_attempts,       :type => Integer, :default => 0
  field :unlock_token,          :type => String
  field :locked_at,             :type => Time
  # Devise Recoverable
  field :reset_password_token,  :type => String
  # Devise Rememberable
  field :remember_token,        :type => String
  field :remember_created_at,   :type => Time
  # Devise Token Authenticable
  field :authentication_token,  :type => String
  # Devise Trackable
  field :sign_in_count,         :type => Integer, :default => 0
  field :current_sign_in_at,    :type => Time
  field :last_sign_in_at,       :type => Time
  field :current_sign_in_ip,    :type => String
  field :last_sign_in_ip,       :type => String
  # Refinery Specific
  field :persistence_token,     :type => String
  field :perishable_token,      :type => String

  #references_and_referenced_in_many :roles, :inverse_of => :users
  references_and_referenced_in_many :roles
  after_save :update_roles

  # has_many :plugins, :class_name => "UserPlugin", :order => "position ASC", :dependent => :destroy
  references_many :plugins, :class_name => "UserPlugin", :dependent => :destroy, :index => true, :inverse_of => :user

  #has_friendly_id :username, :use_slug => true
  slug :username, :index => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # :login is a virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :plugins, :login

  validates :username, :presence => true, :uniqueness => true

  DEVISE_MODULES  = [ :confirmable, :database_authenticatable, :encryptable,
                      :lockable, :omniauthable, :recoverable, :registerable,
                      :rememberable, :timeoutable, :token_authenticatable,
                      :trackable, :validatable ]

  DEVISE_MODULES.each do |method_name|
    self.class.instance_eval do
      define_method :"#{method_name}?" do
        if respond_to? :devise_modules
          devise_modules.include?(method_name)
        else
          false
        end
      end
    end
  end

  index :email,                 :unique => true
  index :username,              :unique => true
  index :confirmation_token,    :unique => true if User.confirmable?
  index :reset_password_token,  :unique => true if User.recoverable?
  index :unlock_token,          :unique => true if User.lockable?

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

  # Extractable Methods

  def self.table_exists?
    included_modules.include? Mongoid::Document
  end

  def self.column_names
    fields
  end

  def plugins=(*plugin_names)
    plugin_names = plugin_names.first
    if persisted? # don't add plugins when the user_id is nil.
      #UserPlugin.delete_all(:user_id => id)
      UserPlugin.where(:user_id => id).each do |plugin|
        plugin.destroy
      end

      plugin_names.each_with_index do |plugin_name, index|
        plugins.create(:name => plugin_name, :position => index) if plugin_name.is_a?(String)
      end
    end
  end

  def authorized_plugins
    plugins.collect { |p| p.name } | Refinery::Plugins.always_allowed.names
  end

  def can_delete?(user_to_delete = self)
    user_to_delete.persisted? and
    !user_to_delete.has_role?(:superuser) and
    Role[:refinery].users.count > 1 and
    id != user_to_delete.id
  end

  def add_role(title)
    raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(Role)
    roles << Role[title] unless has_role?(title)
  end

  def has_role?(title)
    raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(Role)
    (role = Role.find_by_title(title.to_s.camelize)).present? and roles.collect{|r| r.id}.include?(role.id)
  end

  private

  def update_roles
    for role in self.roles
      role.user_ids ||= []
      if !role.user_ids.include?(self.id)
        role.user_ids << self.id
        role.save
      end
    end
  end

end

#  create_table "users", :force => true do |t|
#    t.string   "username",             :null => false
#    t.string   "email",                :null => false
#    t.string   "encrypted_password",   :null => false
#    t.string   "password_salt",        :null => false
#    t.string   "persistence_token"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "perishable_token"
#    t.datetime "current_sign_in_at"
#    t.datetime "last_sign_in_at"
#    t.string   "current_sign_in_ip"
#    t.string   "last_sign_in_ip"
#    t.integer  "sign_in_count"
#    t.string   "remember_token"
#    t.string   "reset_password_token"
#    t.datetime "remember_created_at"
#  end

#  add_index "users", ["id"], :name => "index_users_on_id"

