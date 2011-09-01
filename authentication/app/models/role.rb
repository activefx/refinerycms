class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String

  references_and_referenced_in_many :actors

  before_validation :camelize_title
  validates :title, :uniqueness => true

  index :title

  # Extractable Methods

  def self.table_exists?
    included_modules.include? Mongoid::Document
  end

  def self.column_names
    fields
  end

  def self.find_or_create_by_title(title)
    find_or_create_by(:title => title)
  end

  def self.find_by_title(title)
    where(:title => title).first
  end

  def camelize_title(role_title = self.title)
    self.title = role_title.to_s.camelize
  end

  def self.[](title)
    find_or_create_by_title(title.to_s.camelize)
  end

  def users
    actors.where(:_type => 'User')
  end

  def administrators
    actors.where(:_type => 'Administrator')
  end

end

