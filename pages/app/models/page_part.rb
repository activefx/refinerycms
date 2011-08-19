class PagePart
  include Mongoid::Document
  include Mongoid::Timestamps

  #field :page_id, :type => Integer
  field :title, :type => String
  field :body, :type => String
  field :position, :type => Integer
  #add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
  #add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  #belongs_to :page
  embedded_in :page, :inverse_of => :parts

  default_scope asc(:position)

  #validates :title, :presence => true
  validates_presence_of :title

  attr_accessible :title, :content, :position, :body, :created_at,
                  :updated_at, :page_id

  alias_attribute :content, :body

  #translates :body if respond_to?(:translates)

  def to_param
    "page_part_#{title.downcase.gsub(/\W/, '_')}"
  end

  before_save :normalise_text_fields

  # Extractable Methods

  def self.table_exists?
    included_modules.include? Mongoid::Document
  end

  def self.column_names
    fields
  end

#  if defined?(::PagePart::Translation)
#    ::PagePart::Translation.module_eval do
#      attr_accessible :locale
#    end
#  end

protected
  def normalise_text_fields
    unless body.blank? or body =~ /^\</
      self.body = "<p>#{body.gsub("\r\n\r\n", "</p><p>").gsub("\r\n", "<br/>")}</p>"
    end
  end

end

#  create_table "page_parts", :force => true do |t|
#    t.integer  "page_id"
#    t.string   "title"
#    t.text     "body"
#    t.integer  "position"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end

#  add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
#  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

