require 'devise'

class Actor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Search

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

  # has_many :plugins, :class_name => "UserPlugin", :order => "position ASC", :dependent => :destroy
  references_many :plugins, :class_name => "ActorPlugin", :dependent => :destroy, :index => true, :inverse_of => :actor

  #has_friendly_id :username, :use_slug => true
  slug :username, :index => true

  # Setup accessible (or protected) attributes for your model
  # :login is a virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  attr_accessible nil

  validates :username, :presence => true, :uniqueness => true

  search_in :username

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

  DEVISE_MODULES.each do |method_name|
    self.class.instance_eval do
      define_method :"children_allow_#{method_name}?" do
        true
#        if User.send(:"#{method_name}?") || Admin.send(:"#{method_name}?")
#          true
#        else
#          false
#        end
      end
    end
  end

  # Index Email
  index :email,                 :unique => true
  index( [ [:_type, Mongo::ASCENDING],
           [:email, Mongo::ASCENDING] ],
         :unique => true )

  # Index Username
  index :username,              :unique => true
  index( [ [:_type, Mongo::ASCENDING],
           [:username, Mongo::ASCENDING] ],
         :unique => true )

  # Index Authentication Token
  if children_allow_token_authenticatable?
    index :authentication_token,  :unique => true
    index( [ [:_type, Mongo::ASCENDING],
             [:authentication_token, Mongo::ASCENDING] ],
           :unique => true )
  end

  # Index Remember Token
  if children_allow_rememberable?
    index :remember_token,        :unique => true
    index( [ [:_type, Mongo::ASCENDING],
             [:remember_token, Mongo::ASCENDING] ],
           :unique => true )
  end

  # Index Confirmation Token
  if children_allow_confirmable?
    index :confirmation_token,    :unique => true
    index( [ [:_type, Mongo::ASCENDING],
             [:confirmation_token, Mongo::ASCENDING] ],
           :unique => true )
  end

  # Index Reset Password Token
  if children_allow_recoverable?
    index :reset_password_token,  :unique => true
    index( [ [:_type, Mongo::ASCENDING],
             [:reset_password_token, Mongo::ASCENDING] ],
           :unique => true )
  end

  # Index Unlock Token
  if children_allow_lockable?
    index :unlock_token,          :unique => true
    index( [ [:_type, Mongo::ASCENDING],
             [:unlock_token, Mongo::ASCENDING] ],
           :unique => true )
  end


  # Extractable Methods

  def self.table_exists?
    included_modules.include? Mongoid::Document
  end

  def self.column_names
    fields
  end

  def self.base_class
    self
  end

  def plugins=(*plugin_names)
    plugin_names = plugin_names.first
    if persisted? # don't add plugins when the user_id is nil.
      #UserPlugin.delete_all(:user_id => id)
      ActorPlugin.where(:actor_id => id).each do |plugin|
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
    self.is_a?(Administrator) and
    user_to_delete.persisted? and
    !user_to_delete.has_role?(:superuser) and
    Role[:refinery].actors.count > 1 and
    id != user_to_delete.id
  end

  # Temporary workaround for problems with Mongoid's many to many destroy method
  def remove_role(title)
    raise StandardError, "Role should be the title of the role not a role object." if title.is_a?(Role)
    role = Role.where(:title => title.to_s.camelize).first
    if role
      self.role_ids = self.role_ids.delete_if{|r| r == role.id}
      self.save
      role.actor_ids = role.actor_ids.delete_if{|u| u == self.id}
      role.save
    else
      false
    end
  end

  def add_role(title)
    raise StandardError, "Role should be the title of the role not a role object." if title.is_a?(Role)
    roles << Role[title] unless has_role?(title)
  end

  def has_role?(title)
    raise StandardError, "Role should be the title of the role not a role object." if title.is_a?(Role)
    #(role = Role.find_by_title(title.to_s.camelize)).present? and roles.collect{|r| r.id}.include?(role.id)
    role = Role.where(:title => title.to_s.camelize).first
    role ? role.actors.include?(self) : false
  end

  def type_for_path
    raise StandardError, "Actor is not an administratable object." if self.class == Actor
    self.class.to_s.downcase
  end

  def rememberable_status_helper
    raise StandardError, "Actor is not an administratable object." if self.class == Actor
    if self.remember_token.blank?
      "#{self._type.downcase} does not currently have a remember cookie"
    else
      "#{self._type.downcase} currently has a remember cookie"
    end
  end

  def self.confirmation_time_limit_helper
    raise StandardError, "Actor is not an confirmable object." unless self.confirmable?
    if self.confirm_within == 0
      "#{self.to_s}s have an unlimited amount of time to confirm their account."
    else
      "#{self.to_s}s must confirm their account within #{self.confirm_within / 3600} hours."
    end
  end

  def self.encryptor_name_helper
    raise StandardError, "Actor is not an administratable object." if self == Actor
    self.encryptor.to_s rescue 'bcrypt'
  end

  def self.failed_attempts_helper
    return "" unless self.lock_strategy_enabled?(:failed_attempts)
      "The authentication system is configured to lock a user's account " +
      "after #{self.maximum_attempts} failed sign-in attempts. "
  end

  def self.unlock_strategy_helper
    raise StandardError, "Actor is not an administratable object." if self == Actor
    string = ""
    string << "by waiting #{self.unlock_in / 60} minutes or " if self.unlock_strategy_enabled?(:time)
    string << "by confirming via an emailed link or " if self.unlock_strategy_enabled?(:email)
    string << "by an administrator"
    string
  end

  def self.providers_helper
    Devise.omniauth_providers.map{|p| p.to_s.titleize}.to_sentence
  end

  def self.timeout_helper
    return "" unless self.class.respond_to?(:timeout_in)
    "Sessions are currently configured to timeout in #{self.timeout_in_helper}."
  end

  def self.timeout_in_helper
    "#{(self.timeout_in / 60).to_s} minutes"
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

