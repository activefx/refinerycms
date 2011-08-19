class UserPlugin
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :position, :type => Integer

  referenced_in :user, :inverse_of => :plugins

  default_scope asc(:position)

  attr_accessible :user_id, :name, :position

  index :name
  index(
    [
      [ :user_id, Mongo::ASCENDING ],
      [ :name, Mongo::ASCENDING ]
    ],
    :unique => true
  )

  def self.find_by_user_id(user_id)
    where(:user_id => user_id).first
  end

end

#  field :user_id, :type => Integer
#  field :name, :type => String
#  field :position, :type => Integer
#  #add_index "user_plugins", ["name"], :name => "index_user_plugins_on_title"
#  #add_index "user_plugins", ["user_id", "name"], :name => "index_unique_user_plugins", :unique => true

