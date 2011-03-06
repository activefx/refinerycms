# https://gist.github.com/853253

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  # Quickly add a new mock provider
  # OmniAuth.config.add_mock(:twitter, {:uid => '12345'})
  # This information will automatically be merged with the default info so it will be a valid response
  # Default info:
  # @mock_auth={:default=>{"uid"=>"1234", "user_info"=>{"name"=>"Bob Example", "email"=>"bob@example.com", "nickname"=>"bob"}}}

  # Default auth_hash method
  #  def auth_hash
  #    OmniAuth::Utils.deep_merge(super, {
  #      'credentials' => {
  #        'token' => @access_token.token,
  #        'secret' => @access_token.secret
  #      }, 'extra' => {
  #        'access_token' => @access_token
  #      }
  #    })
  #  end

  OmniAuth.config.mock_auth[:twitter] = {
    'uid' => '819797',
    'user_info' => {
      'nickname' => 'episod',
      'name' => 'Taylor Singletary',
      'location' => 'San Francisco, CA',
      'image' => 'http://a0.twimg.com/profile_images/1258681373/hobolumbo.jpg',
      'description' => 'Reality Technician, Developer Advocate at Twitter, hobolumbo',
      'urls' => {
        'Website' => 'http://t.co/op3b03h',
        'Twitter' => 'http://twitter.com/episod'
      }
    },
    'credentials' => {
      'token' => '819797-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw',
      'secret' => 'J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA'
    },
    'extra' => {
      'access_token' => 'oauth_token=819797-Jxq8aYUDRmykzVKrgoLhXSq67TEa5ruc4GJC2rWimw&oauth_token_secret=J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA&user_id=819797&screen_name=episod'
    }
  }


  OmniAuth.config.mock_auth[:facebook] = {
    'uid' => '1234',
    'user_info' => {},
    'credentials' => {
      'token' => @access_token.token,
      'secret' => @access_token.secret
    }, 'extra' => {
      'access_token' => @access_token
    }
  }

#      def user_data
#          @data ||= MultiJson.decode(@access_token.get('/me', {}, { "Accept-Language" => "en-us,en;"}))
#        end

#        def request_phase
#          options[:scope] ||= "email,offline_access"
#          super
#        end

#        def user_info
#          {
#            'nickname' => user_data["link"].split('/').last,
#            'email' => (user_data["email"] if user_data["email"]),
#            'first_name' => user_data["first_name"],
#            'last_name' => user_data["last_name"],
#            'name' => "#{user_data['first_name']} #{user_data['last_name']}",
#            'image' => "http://graph.facebook.com/#{user_data['id']}/picture?type=square",
#            'urls' => {
#              'Facebook' => user_data["link"],
#              'Website' => user_data["website"],
#            }
#          }
#        end

#        def auth_hash
#          OmniAuth::Utils.deep_merge(super, {
#            'uid' => user_data['id'],
#            'user_info' => user_info,
#            'extra' => {'user_hash' => user_data}
#          })
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
# OmniAuth.config.mock_auth[:google_apps] = { }


#  Devise::OmniAuth.test_mode!

#  FACEBOOK_INFO = read_fixture('facebook_me.js')
#  DEFAULT_EMAIL = JSON.parse(FACEBOOK_INFO)['email']
#  DEFAULT_PASSWORD = 'password'
#  DEFAULT_FACEBOOK_UID = JSON.parse(FACEBOOK_INFO)['id']
#  DEFAULT_FACEBOOK_TOKEN = 'abcdef'
#  ACCESS_TOKEN = { :access_token => DEFAULT_FACEBOOK_TOKEN }

#  AfterConfiguration do
#    Devise::OmniAuth.short_circuit_authorizers!
#    Devise::OmniAuth.stub!(:facebook) do |b|
#      b.post('/oauth/access_token') { [200, {}, ACCESS_TOKEN.to_json] }
#      b.get('/me?access_token=abcdef') { [200, {}, FACEBOOK_INFO] }
#    end
#  end

#  at_exit do
#    Devise::OmniAuth.unshort_circuit_authorizers!
#    Devise::OmniAuth.reset_stubs!
#  end

#  FakeWeb.allow_net_connect = %r[^https?://(localhost|127.0.0.1)]
#  FakeWeb.register_uri(:get, 'https://graph.facebook.com/me?access_token=abcdef', :response => read_fixture('facebook_me.response'))
#  FakeWeb.register_uri(:get, 'https://graph.facebook.com/me/friends?access_token=abcdef', :response => read_fixture('facebook_my_friends.response'))


#  def current_user
#    User.where(:email => DEFAULT_EMAIL).first # || User.find_for_facebook_registration(YAML.load(read_fixture('facebook_registration.yml')))
#  end

