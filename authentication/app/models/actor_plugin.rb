class ActorPlugin
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :position, :type => Integer

  belongs_to :actor, :inverse_of => :plugins, :index => true

  default_scope asc(:position)

  attr_accessible :user_id, :name, :position

  index :name
  index(
    [
      [ :actor_id, Mongo::ASCENDING ],
      [ :name, Mongo::ASCENDING ]
    ]
  )

  def self.find_by_actor_id(actor_id)
    where(:actor_id => actor_id).first
  end

end

#  field :user_id, :type => Integer
#  field :name, :type => String
#  field :position, :type => Integer
#  #add_index "user_plugins", ["name"], :name => "index_user_plugins_on_title"
#  #add_index "user_plugins", ["user_id", "name"], :name => "index_unique_user_plugins", :unique => true

