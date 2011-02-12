class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String

  #has_and_belongs_to_many :users
  references_and_referenced_in_many :users

  before_validation :camelize_title
  validates :title, :uniqueness => true

  # Extractable Methods

  def self.table_exists?
    included_modules.include? Mongoid::Document
  end

  def self.column_names
    fields
  end

  def camelize_title(role_title = self.title)
    self.title = role_title.to_s.camelize
  end

  def self.[](title)
    find_or_create_by_title(title.to_s.camelize)
  end

end

