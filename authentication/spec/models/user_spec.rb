require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe User do

  context "devise modules" do
    subject { User }
    it { should be_confirmable }
    it { should be_database_authenticatable }
    it { should_not be_encryptable } #because we're using bcrypt
    it { should be_lockable }
    it { should be_omniauthable }
    it { should be_recoverable }
    it { should be_registerable }
    it { should be_rememberable }
    it { should_not be_timeoutable }
    it { should_not be_token_authenticatable }
    it { should be_trackable }
    it { should be_validatable }
  end

  it "should inherit from the Actor class" do
    User.should < Actor
  end

  it "should not be valid without any attributes" do
    User.new.should_not be_valid
  end

  it "should be valid with valid attributes" do
    Factory.build(:user).should be_valid
  end

  it "should belong to the appropriate class from the corresponding factory" do
    Factory(:user).is_a?(User).should == true
  end

  it "should belong to the appropriate class from the corresponding factory (refinery user)" do
    Factory(:site_user).is_a?(User).should == true
  end

  before(:each) do
    Actor.delete_all
    Role.delete_all
  end

  context "Omniauth", :omniauth => true do

    before(:each) do
      @user = User.new
      @omniauth = { 'uid' => '819797',
                    'provider' => 'twitter',
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
    end

    context "build_omniauth_params" do

      it "should include provider and uid" do
        @user.build_omniauth_params(@omniauth).keys.should include(:provider)
        @user.build_omniauth_params(@omniauth).keys.should include(:uid)
      end

      it "should include credentials" do
        @user.build_omniauth_params(@omniauth).keys.should include(:token)
        @user.build_omniauth_params(@omniauth).keys.should include(:secret)
      end

      it "should not include credential when missing" do
        @omniauth.delete('credentials')
        @user.build_omniauth_params(@omniauth).keys.should_not include(:token)
      end

      it "should include all omniauth parameters" do
         @user.build_omniauth_params(@omniauth)[:omniauth].should == @omniauth
      end

    end

    context "apply_user_info" do

      it "should set the username if the user doesn't have one" do
        @user.apply_user_info(@omniauth['user_info'])
        @user.username.should == 'episod'
      end

      it "should not set the username to the email if the omniauth hash doesn't have a nickname" do
        @omniauth['user_info'].delete('nickname')
        @omniauth['user_info']['email'] = 'user@example.com'
        @user.apply_user_info(@omniauth['user_info'])
        @user.username.should == 'user@example.com'
      end

      it "should set the email if the user doesn't have one" do
        @omniauth['user_info']['email'] = 'user@example.com'
        @user.apply_user_info(@omniauth['user_info'])
        @user.username.should == 'episod'
      end

      it "should not set the email and username if the omniauth hash doesn't include nickname or email" do
        @omniauth['user_info'].delete('nickname')
        @user.apply_user_info(@omniauth['user_info'])
        @user.username.should be_blank
        @user.email.should be_blank
      end

    end

    context "apply_omniauth" do

      it "should not build the user token if provider or uid is missing" do
        @omniauth.delete('provider')
        @user.apply_omniauth(@omniauth)
        @user.user_tokens.first.should be_nil
      end

      it "should not save the user if the user is new" do
        @user.apply_omniauth(@omniauth)
        @user.should be_new_record
      end

      it "should build the user token" do
        @user.apply_omniauth(@omniauth)
        @token = @user.user_tokens.first
        @token.provider.should == 'twitter'
      end

      it "should save the user token when saving the user" do
        # set passwords so user is valid
        @user = User.omniauth_initialization
        # set the email so user is valid
        @omniauth['user_info']['email'] = 'user@example.com'
        @user.apply_omniauth(@omniauth)
        @user.save
        @token = UserToken.where(:provider => @omniauth['provider'], :uid => @omniauth['uid']).first
        @user.should_not be_new_record
        @token.should_not be_nil
        @token.user.id.should == @user.id
      end

    end

  end

  # Tests to confirm working Mongoid references_and_referenced_in_many relationship,
  # some errors still occuring, for example with the destroy method ( user.roles.destroy(role) )
  # Some duplication with other tests, will remove once issues are worked out
  context "Roles Relationship", :roles => true do

    it "should start each example without any users" do
      User.count.should == 0
    end

    it "should start each example without any roles" do
      Role.count.should == 0
    end

    it "references roles in the user model" do
      User.should reference_and_be_referenced_in_many(:roles)
    end

    it "references users in the role model" do
      Role.should reference_and_be_referenced_in_many(:actors)
    end

    context "setting the relationships from the user side" do

      before(:each) do
        @user = Factory(:user)
        @user.save
        @role = Role.create(:title => 'refinery')
      end

      it "should add update both models when adding a role to a user" do
        @user.roles << @role
        @user.roles.size.should == 1
      end

      it "should add update both models when adding a role to a user" do
        @user.roles << @role
        @role.actors.size.should == 1
      end

      it "should work with the [] accessor method" do
        @user.roles << @role
        Role[:refinery].actors.size.should == 1
      end

      it "the role should be the same as the one accessible from the [] method" do
        @role.should == Role[:refinery]
      end

      it "should add to the user's roles with the add_user method" do
        @user.add_role(:refinery)
        @user.roles.size.should == 1
      end

      it "should add to the role's users with the add_user method" do
        @user.add_role(:refinery)
        Role[:refinery].actors.size.should == 1
      end

      it "should add to the role's users with the add_user method" do
        @user.add_role(:refinery)
        @role.reload
        @role.actors.size.should == 1
      end

      it "should return true from has_role? method when the user has the role" do
        @user.add_role(:refinery)
        @user.has_role?(:refinery).should be_true
      end

      it "should return false from has_role? method when the user does not have the role" do
        @user.add_role(:refinery)
        @user.has_role?(:something).should be_false
      end

      it "should destory the association when using remove_role" do
        @user.add_role(:refinery)
        @user.remove_role(:refinery)
        @user.has_role?(:refinery).should be_false
      end

      it "should set multiple roles" do
        @selected_role_names = ['First', 'Second', 'Third']
        @user.roles = @selected_role_names.collect{|r| Role[r.downcase.to_sym]}
        @user.has_role?(:first).should be_true
        @user.has_role?(:second).should be_true
        @user.has_role?(:third).should be_true
      end

    end

    context "setting the relationships from the role side" do

      before(:each) do
        @user= Factory(:user)
        @user.save
        @role = Role.create(:title => 'refinery')
      end

      it "should add update both models when adding a user to a role" do
        @role.actors << @user
        @user.roles.size.should == 1
      end

      it "should add update both models when adding a user to a role" do
        @role.actors << @user
        @role.actors.size.should == 1
      end

      it "should work with the [] accessor method" do
        @role.actors << @user
        Role[:refinery].actors.size.should == 1
      end

      it "the role should be the same as the one accessible from the [] method" do
        Role[:refinery].should == @role
      end

    end

  end

  context "Roles" do
    context "add_role" do
      it "raises Exception when Role object is passed" do
        user = Factory(:user)
        lambda{ user.add_role(Role.new)}.should raise_exception
      end

      it "adds a Role to the User when role not yet assigned to User" do
        user = Factory(:user)
        lambda {
          user.add_role(:new_role)
        }.should change(user.roles, :count).by(1)
        user.roles.collect(&:title).should include("NewRole")
      end

      it "does not add a Role to the User when this Role is already assigned to User" do
        user = Factory(:site_user)
        lambda {
          user.add_role(:refinery)
        }.should_not change(user.roles, :count).by(1)
        user.roles.collect(&:title).should include("Refinery")
      end
    end

    context "has_role" do
      it "raises Exception when Role object is passed" do
        user = Factory(:user)
        lambda{ user.has_role?(Role.new)}.should raise_exception
      end

      it "returns the true if user has Role" do
        user = Factory(:site_user)
        user.has_role?(:refinery).should be_true
      end

      it "returns false if user hasn't the Role" do
        user = Factory(:site_user)
        user.has_role?(:refinery_fail).should be_false
      end
    end

    describe "role association" do
      it "have a roles attribute" do
        Factory(:user).should respond_to(:roles)
      end
    end
  end

  context "validations" do
    # email and password validations are done by including devises validatable
    # module so those validations are not tested here
    before(:each) do
      @attr = {
        :username => "RefineryCMS",
        :email => "refinery@cms.com",
        :password => "123456",
        :password_confirmation => "123456"
      }
    end

    it "requires username" do
      User.new(@attr.merge(:username => "")).should_not be_valid
    end

    it "rejects duplicate usernames" do
      User.create!(@attr)
      User.new(@attr.merge(:email => "another@email.com")).should_not be_valid
    end
  end

  describe ".find_for_database_authentication" do
    it "finds user either by username or email" do
      user = Factory(:user)
      User.find_for_database_authentication(:login => user.username).should == user
      User.find_for_database_authentication(:login => user.email).should == user
    end
  end

  describe "#can_delete?" do
    before(:each) do
      Actor.delete_all
      Role.delete_all
      @user= Factory(:site_user)
      @user_not_persisted = Factory.build(:site_user)
      @super_user = Factory(:site_user)
      @super_user.add_role(:superuser)
    end

    context "won't allow to delete" do
      it "not persisted user record" do
        @user.can_delete?(@user_not_persisted).should be_false
      end

      it "user with superuser role" do
        @user.can_delete?(@super_user).should be_false
      end

      it "if user count with refinery role <= 1" do
        @user.remove_role(:refinery)
        @super_user.can_delete?(@user).should be_false
      end

      it "if user count with refinery role <= 1" do
        Role[:refinery].actors.delete(@user)
        @super_user.can_delete?(@user).should be_false
      end

      it "user himself" do
        @user.can_delete?(@user).should be_false
      end

      it "if all conditions return true, but user is not an administrator" do
        @super_user.can_delete?(@user).should be_false
      end
    end

  end

  describe "#plugins=" do
    it "assigns plugins to user" do
      user = Factory(:user)
      plugin_list = ["refinery_one", "refinery_two", "refinery_three"]
      user.plugins = plugin_list
      user.plugins.collect { |p| p.name }.should == plugin_list
    end
  end

  describe "#authorized_plugins" do
    it "returns array of user and always allowd plugins" do
      user = Factory(:user)
      ["refinery_one", "refinery_two", "refinery_three"].each_with_index do |name, index|
        user.plugins.create!(:name => name, :position => index)
      end
      user.authorized_plugins.should == user.plugins.collect { |p| p.name } | Refinery::Plugins.always_allowed.names
    end
  end

  describe "plugins association" do
    before(:each) do
      @user= Factory(:user)
      @plugin_list = ["refinery_one", "refinery_two", "refinery_three"]
      @user.plugins = @plugin_list
    end

    it "have a plugins attribute" do
      @user.should respond_to(:plugins)
    end

    it "returns plugins in ASC order" do
      @user.plugins[0].name.should == @plugin_list[0]
      @user.plugins[1].name.should == @plugin_list[1]
      @user.plugins[2].name.should == @plugin_list[2]
    end

    it "deletes associated plugins" do
      @user.destroy
      ActorPlugin.find_by_actor_id(@user.id).should be_nil
    end
  end
end

