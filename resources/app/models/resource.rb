class Resource
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :file_mime_type, :type => String
  field :file_name, :type => String
  field :file_size, :type => Integer
  field :file_uid, :type => String
  field :file_ext, :type => String

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

  attr_accessible :id, :file
  # What is the max resource size a user can upload
  MAX_SIZE_IN_MB = 50

  resource_accessor :file

  validates :file, :presence => {},
                   :length   => { :maximum => MAX_SIZE_IN_MB.megabytes }

  # Docs for acts_as_indexed http://github.com/dougal/acts_as_indexed
  # acts_as_indexed :fields => [:file_name, :title, :type_of_content]

  # Docs for Mongoid Search http://github.com/mauriciozaffari/mongoid_search
  search_in :file_name, :title, :type_of_content

  # when a dialog pops up with resources, how many resources per page should there be
  PAGES_PER_DIALOG = 12

  # when listing resources out in the admin area, how many resources should show per page
  PAGES_PER_ADMIN_INDEX = 20

  delegate :ext, :size, :mime_type, :url, :to => :file

  # used for searching
  def type_of_content
    mime_type.split("/").join(" ")
  end

  # Returns a titleized version of the filename
  # my_file.pdf returns My File
  def title
    CGI::unescape(file_name.to_s).gsub(/\.\w+$/, '').titleize
  end

  class << self

    def find_by_file_name(file_name)
      where(:file_name => file_name).first
    end

    # How many resources per page should be displayed?
    def per_page(dialog = false)
      dialog ? PAGES_PER_DIALOG : PAGES_PER_ADMIN_INDEX
    end

    def create_resources(params)
      resources = []

      unless params.present? and params[:file].is_a?(Array)
        resources << create(params)
      else
        params[:file].each do |resource|
          resources << create(:file => resource)
        end
      end

      resources
    end
  end
end

#  create_table "resources", :force => true do |t|
#    t.string   "file_mime_type"
#    t.string   "file_name"
#    t.integer  "file_size"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "file_uid"
#    t.string   "file_ext"
#  end

