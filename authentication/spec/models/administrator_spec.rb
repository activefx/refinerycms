require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe Administrator do

  context "devise modules" do
    subject { Administrator }
    it { should_not be_confirmable }
    it { should be_database_authenticatable }
    it { should_not be_encryptable } #because we're using bcrypt
    it { should be_lockable }
    it { should_not be_omniauthable }
    it { should be_recoverable }
    it { should_not be_registerable }
    it { should be_rememberable }
    it { should_not be_timeoutable }
    it { should_not be_token_authenticatable }
    it { should be_trackable }
    it { should be_validatable }
  end

  it "should inherit from the Actor class" do
    Administrator.should < Actor
  end

  it "should not be valid without any attributes" do
    Administrator.new.should_not be_valid
  end

  it "should be valid with valid attributes" do
    Factory.build(:administrator).should be_valid
  end

  it "should belong to the appropriate class from the corresponding factory" do
    Factory(:administrator).is_a?(Administrator).should == true
  end

  it "should belong to the appropriate class from the corresponding factory (refinery user)" do
    Factory(:refinery_user).is_a?(Administrator).should == true
  end

  before(:all) do
    Actor.delete_all
    Role.delete_all
  end

  # Tests to confirm working Mongoid references_and_referenced_in_many relationship,
  # some errors still occuring, for example with the destroy method ( user.roles.destroy(role) )
  # Some duplication with other tests, will remove once issues are worked out
  context "Roles Relationship", :roles => true do

    before(:each) do
      Actor.delete_all
      Role.delete_all
    end

    it "should start each example without any users" do
      Administrator.count.should == 0
    end

    it "should start each example without any roles" do
      Role.count.should == 0
    end

    it "references roles in the user model" do
      Administrator.should reference_and_be_referenced_in_many(:roles)
    end

    it "references users in the role model" do
      Role.should reference_and_be_referenced_in_many(:actors)
    end

    context "setting the relationships from the user side" do

      before(:each) do
        @administrator = Factory(:administrator)
        @administrator.save
        @role = Role.create(:title => 'refinery')
      end

      it "should add update both models when adding a role to a user" do
        @administrator.roles << @role
        @administrator.roles.size.should == 1
      end

      it "should add update both models when adding a role to a user" do
        @administrator.roles << @role
        @role.actors.size.should == 1
      end

      it "should work with the [] accessor method" do
        @administrator.roles << @role
        Role[:refinery].actors.size.should == 1
      end

      it "the role should be the same as the one accessible from the [] method" do
        @role.should == Role[:refinery]
      end

      it "should add to the user's roles with the add_user method" do
        @administrator.add_role(:refinery)
        @administrator.roles.size.should == 1
      end

      it "should add to the role's users with the add_user method" do
        @administrator.add_role(:refinery)
        Role[:refinery].actors.size.should == 1
      end

      it "should add to the role's users with the add_user method" do
        @administrator.add_role(:refinery)
        @role.reload
        @role.actors.size.should == 1
      end

      it "should return true from has_role? method when the user has the role" do
        @administrator.add_role(:refinery)
        @administrator.has_role?(:refinery).should be_true
      end

      it "should return false from has_role? method when the user does not have the role" do
        @administrator.add_role(:refinery)
        @administrator.has_role?(:something).should be_false
      end

      it "should destory the association when using remove_role" do
        @administrator.add_role(:refinery)
        @administrator.remove_role(:refinery)
        @administrator.has_role?(:refinery).should be_false
      end

      it "should set multiple roles" do
        @selected_role_names = ['First', 'Second', 'Third']
        @administrator.roles = @selected_role_names.collect{|r| Role[r.downcase.to_sym]}
        @administrator.has_role?(:first).should be_true
        @administrator.has_role?(:second).should be_true
        @administrator.has_role?(:third).should be_true
      end

    end

    context "setting the relationships from the role side" do

      before(:each) do
        @administrator= Factory(:user)
        @administrator.save
        @role = Role.create(:title => 'refinery')
      end

      it "should add update both models when adding a user to a role" do
        @role.actors << @administrator
        @administrator.roles.size.should == 1
      end

      it "should add update both models when adding a user to a role" do
        @role.actors << @administrator
        @role.actors.size.should == 1
      end

      it "should work with the [] accessor method" do
        @role.actors << @administrator
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
        administrator = Factory(:administrator)
        lambda{ administrator.add_role(Role.new)}.should raise_exception
      end

      it "adds a Role to the Administrator when role not yet assigned to Administrator" do
        administrator = Factory(:administrator)
        lambda {
          administrator.add_role(:new_role)
        }.should change(administrator.roles, :count).by(1)
        administrator.roles.collect(&:title).should include("NewRole")
      end

      it "does not add a Role to the Administrator when this Role is already assigned to Administrator" do
        administrator = Factory(:refinery_user)
        lambda {
          administrator.add_role(:refinery)
        }.should_not change(administrator.roles, :count).by(1)
        administrator.roles.collect(&:title).should include("Refinery")
      end
    end

    context "has_role" do
      it "raises Exception when Role object is passed" do
        administrator = Factory(:administrator)
        lambda{ administrator.has_role?(Role.new)}.should raise_exception
      end

      it "returns the true if user has Role" do
        administrator = Factory(:refinery_user)
        administrator.has_role?(:refinery).should be_true
      end

      it "returns false if user hasn't the Role" do
        administrator = Factory(:refinery_user)
        administrator.has_role?(:refinery_fail).should be_false
      end
    end

    describe "role association" do
      it "have a roles attribute" do
        Factory(:administrator).should respond_to(:roles)
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
      Administrator.new(@attr.merge(:username => "")).should_not be_valid
    end

    it "rejects duplicate usernames" do
      Administrator.create!(@attr)
      Administrator.new(@attr.merge(:email => "another@email.com")).should_not be_valid
    end
  end

  describe ".find_for_database_authentication" do
    it "finds user either by username or email" do
      administrator = Factory(:administrator)
      Administrator.find_for_database_authentication(:login => administrator.username).should == administrator
      Administrator.find_for_database_authentication(:login => administrator.email).should == administrator
    end
  end

  describe "#can_delete?" do
    before(:each) do
      Actor.delete_all
      Role.delete_all
      @administrator= Factory(:refinery_user)
      @administrator_not_persisted = Factory.build(:refinery_user)
      @super_user = Factory(:refinery_user)
      @super_user.add_role(:superuser)
    end

    context "won't allow to delete" do
      it "not persisted user record" do
        @administrator.can_delete?(@administrator_not_persisted).should be_false
      end

      it "user with superuser role" do
        @administrator.can_delete?(@super_user).should be_false
      end

      it "if user count with refinery role <= 1" do
        @administrator.remove_role(:refinery)
        @super_user.can_delete?(@administrator).should be_false
      end

      #it "if user count with refinery role <= 1" do
      #  Role[:refinery].actors.delete(@administrator)
      #  @super_user.can_delete?(@administrator).should be_false
      #end

      it "user himself" do
        @administrator.can_delete?(@administrator).should be_false
      end
    end

    context "allow to delete" do
      it "if all conditions return true" do
        @super_user.can_delete?(@administrator).should be_true
      end
    end
  end

  describe "#plugins=" do
    it "assigns plugins to user" do
      administrator = Factory(:administrator)
      plugin_list = ["refinery_one", "refinery_two", "refinery_three"]
      administrator.plugins = plugin_list
      administrator.plugins.collect { |p| p.name }.should == plugin_list
    end
  end

  describe "#authorized_plugins" do
    it "returns array of user and always allowd plugins" do
      administrator = Factory(:user)
      ["refinery_one", "refinery_two", "refinery_three"].each_with_index do |name, index|
        administrator.plugins.create!(:name => name, :position => index)
      end
      administrator.authorized_plugins.should == administrator.plugins.collect { |p| p.name } | Refinery::Plugins.always_allowed.names
    end
  end

  describe "plugins association" do
    before(:each) do
      @administrator= Factory(:administrator)
      @plugin_list = ["refinery_one", "refinery_two", "refinery_three"]
      @administrator.plugins = @plugin_list
    end

    it "have a plugins attribute" do
      @administrator.should respond_to(:plugins)
    end

    it "returns plugins in ASC order" do
      @administrator.plugins[0].name.should == @plugin_list[0]
      @administrator.plugins[1].name.should == @plugin_list[1]
      @administrator.plugins[2].name.should == @plugin_list[2]
    end

    it "deletes associated plugins" do
      @administrator.destroy
      ActorPlugin.find_by_actor_id(@administrator.id).should be_nil
    end
  end
end

