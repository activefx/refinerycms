class RefinerySetting
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :name, :type => String
  field :value, :type => Hash
  field :destroyable, :type => Boolean, :default => true
  field :scoping, :type => String
  field :restricted, :type => Boolean, :default => false
  field :callback_proc_as_string, :type => String
  field :form_value_type, :type => String

  index :name

  # Extractable Methods

  def self.table_exists?
    included_modules.include? Mongoid::Document
  end

  def self.column_names
    fields
  end

  # Model Specific Methods

  def self.find_or_initialize_by_name_and_scoping(options={})
    #find_or_initialize_by_name_and_scoping(:name => name.to_s, :scoping => scoping)
    find_or_initialize_by(:name => options[:name].to_s, :scoping => options[:scoping])
  end

  def self.find_by_name(name, options={:conditions=>{}})
    #find_by_name(:creating_from_scratch.to_s, :conditions => {:scoping => 'rspec_testing'})
    where(:name => name, :scoping => options[:conditions][:scoping]).first
  end

  def self.find_or_create_by_name(name, options={})
    registration = where(:name => name).first
    if registration.nil?
      return create(options.merge({:name => name}))
    else
      return registration
    end
  end

  FORM_VALUE_TYPES = [
    ['Multi-line', 'text_area'],
    ['Checkbox', 'check_box']
  ]

  #validates :name, :presence => true
  validates_presence_of :name

  #serialize :value # stores into YAML format
  #serialize :callback_proc_as_string

  # Docs for acts_as_indexed http://github.com/dougal/acts_as_indexed
  #acts_as_indexed :fields => [:name]

  # Docs for Mongoid Search http://github.com/mauriciozaffari/mongoid_search
  search_in :name

#  before_save do |setting|
#    setting.restricted = false if setting.restricted.nil?
#  end

#  after_save do |setting|
#    setting.class.rewrite_cache
#  end

  before_save :set_restricted_callback

  after_save :rewrite_cache_callback

  after_destroy :rewrite_cache_callback

  def set_restricted_callback
    self.restricted = false if self.restricted.nil?
  end
  protected :set_restricted_callback

  def rewrite_cache_callback
    self.class.rewrite_cache
  end
  protected :rewrite_cache_callback

  class << self
    # Number of settings to show per page when using will_paginate
    def per_page
      12
    end

    def ensure_cache_exists!
      if (result = Rails.cache.read(cache_key)).nil?
        result = rewrite_cache
      end

      result
    end
    protected :ensure_cache_exists!

    def cache_read(name = nil, scoping = nil)
      result = ensure_cache_exists!

      if name.present?
        scoping = scoping.to_s if scoping.is_a?(Symbol)
        result = result.detect do |rs|
          rs[:name] == name.to_s.downcase.to_sym and rs[:scoping] == scoping
        end
        result = result[:value] if !result.nil? and result.keys.include?(:value)
      end

      result
    end

    def to_cache(settings)
      settings.collect do |rs|
        {
          :name => rs.name.to_s.downcase.to_sym,
          :value => rs.value,
          :scoping => rs.scoping,
          :destroyable => rs.destroyable
        }
      end
    end

    def rewrite_cache
      # delete cache
      Rails.cache.delete(cache_key)

      # generate new cache
      result = (to_cache(all) if (table_exists? rescue false))

      # write cache
      Rails.cache.write(cache_key, result)

      # return cache, or lack thereof.
      result ||= []
    end

    def cache_key
      [Refinery.base_cache_key, 'refinery_settings_cache'].join('_')
    end

    # find_or_set offers a convenient way to
    def find_or_set(name, the_value, options={})
      # Merge default options with supplied options.
      options = {
        :scoping => nil, :restricted => false,
        :callback_proc_as_string => nil, :form_value_type => 'text_area'
      }.merge(options)

      # try to find the setting first
      value = get(name, :scoping => options[:scoping])

      # if the setting's value is nil, store a new one using the existing functionality.
      value = set(name, options.merge({:value => the_value})) if value.nil?

      # Return what we found.
      value
    end

    alias :get_or_set :find_or_set

    # Retrieve the current value for the setting whose name is supplied.
    def get(name, options = {})
      options = {:scoping => nil}.update(options)
      cache_read(name, options[:scoping])
    end

    alias :[] :get

    def set(name, value)
      return (value.is_a?(Hash) ? value[:value] : value) unless (table_exists? rescue false)

      scoping = (value[:scoping] if value.is_a?(Hash) and value.has_key?(:scoping))
      setting = find_or_initialize_by_name_and_scoping(:name => name.to_s, :scoping => scoping)

      # you could also pass in {:value => 'something', :scoping => 'somewhere'}
      unless value.is_a?(Hash) and value.has_key?(:value)
        setting.value = value
      else
        # set the value last, so that the other attributes can transform it if required.
        setting.form_value_type = value[:form_value_type] || 'text_area' if setting.respond_to?(:form_value_type)
        setting.scoping = value[:scoping] if value.has_key?(:scoping)
        setting.callback_proc_as_string = value[:callback_proc_as_string] if value.has_key?(:callback_proc_as_string)
        setting.destroyable = value[:destroyable] if value.has_key?(:destroyable)
        setting.value = value[:value]
      end

      # Save because we're in a setter method.
      setting.save

      # Return the value
      setting.value
    end

    # DEPRECATED for removal at >= 0.9.9
    def []=(name, value)
      warning = ["\n*** DEPRECATION WARNING ***"]
      warning << "You should not use this anymore: RefinerySetting[#{name.inspect}] = #{value.inspect}."
      warning << "\nInstead, you should use RefinerySetting.set(#{name.inspect}, #{value.inspect})"
      warning << ""
      warning << "Called from: #{caller.first.inspect}\n\n"
      $stdout.puts warning.join("\n")

      set(name, value)
    end
  end

  # prettier version of the name.
  # site_name becomes Site Name
  def title
    name.titleize
  end

  # form_value is so that on the web interface we can display a sane value.
  def form_value
    unless self[:value].blank? or self[:value].is_a?(String)
      YAML::dump(self[:value])
    else
      self[:value]
    end
  end

  def value
    replacements!(self[:value])
  end

  def value=(new_value)
    # must convert "1" to true and "0" to false when supplied using 'check_box', unfortunately.
    if ["1", "0"].include?(new_value) and form_value_type == 'check_box'
      new_value = new_value == "1" ? true : false
    end

    # must convert to string if true or false supplied otherwise it becomes 0 or 1, unfortunately.
    if [true, false].include?(new_value)
      new_value = new_value.to_s
    end

    super
  end

  def callback_proc
    eval("Proc.new{#{callback_proc_as_string} }") if callback_proc_as_string.present?
  end

private
  # Below is not very nice, but seems to be required. The problem is when Rails
  # serialises a fields like booleans it doesn't retrieve it back out as a boolean
  # it just returns a string. This code maps the two boolean values
  # correctly so that a boolean is returned instead of a string.
  REPLACEMENTS = {"true" => true, "false" => false}

  def replacements!(current_value)
    # This bit handles true and false so that true and false are actually returned
    # not "0" and "1"
    REPLACEMENTS.each do |current, new_value|
      current_value = new_value if current_value == current
    end

    # converts the serialised value back to an integer
    # if the value is an integer
    begin
      if current_value.to_i.to_s == current_value
        current_value = current_value.to_i
      end
    rescue
      current_value
    end

    current_value
  end

end

#  create_table "refinery_settings", :force => true do |t|
#    t.string   "name"
#    t.text     "value"
#    t.boolean  "destroyable",             :default => true
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.string   "scoping"
#    t.boolean  "restricted",              :default => false
#    t.string   "callback_proc_as_string"
#    t.string   "form_value_type"
#  end

#  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

