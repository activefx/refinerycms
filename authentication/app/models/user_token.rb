class UserToken
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, :type => String
  field :uid, :type => String
  field :token, :type => String
  field :secret, :type => String
  field :omniauth, :type => Hash

  referenced_in :user, :inverse_of => :user_tokens

  index( [ [:provider, Mongo::ASCENDING],
           [:uid, Mongo::ASCENDING] ],
         :unique => true )

  validates_presence_of   :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_by_provider_and_uid(provider, uid)
    where(:provider => provider, :uid => uid).first
  end

  def self.find_by_provider(provider)
    desc(:updated_at).where(:provider => provider).first
  end

#  def self.find_from_hash(hash)
#    find_by_provider_and_uid(hash['provider'], hash['uid'])
#  end

#  def self.create_from_hash(hash, user = nil)
#    user ||= User.create(hash)
#    self.create(hash.merge(:user => user).merge(hash['credentials']))
#    #, :uid => hash['uid'], :provider => hash['provider'])
#  end

#  def apply_omniauth(omniauth)
#    return false if (omniauth['credentials'].blank? rescue true)
#    self.attributes = {
#      :provider => omniauth['provider'],
#      :user_id => self.user_id,
#      :uid => omniauth['uid'],
#      :token => omniauth['credentials']['token'],
#      :secret => omniauth['credentials']['secret']
#    }
#    self.save
#  end

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end

end

