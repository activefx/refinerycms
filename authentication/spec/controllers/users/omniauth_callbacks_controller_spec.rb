#require 'spec_helper'

## https://gist.github.com/792715
#describe Users::OauthCallbacksController, "handle facebook authentication callback" do

#  describe "#annonymous user" do
#    context "when facebook email doesn't exist in the system" do
#      before(:each) do
#        stub_env_for_omniauth

#        get :facebook
#        @user = User.where(:email => "ghost@nobody.com").first
#      end

#      it { @user.should_not be_nil }

#      it "should create authentication with facebook id" do
#        user_token = @user.user_tokens.where(:provider => "facebook", :uid => "1234").first
#        user_token.should_not be_nil
#      end

#      it { should be_user_signed_in }

#      it { response.should redirect_to tasks_path }
#    end

#    context "when facebook email already exist in the system" do
#      before(:each) do
#        stub_env_for_omniauth

#        User.create!(:email => "ghost@nobody.com", :password => "my_secret")
#        get :facebook
#      end

#      it { flash[:notice].should == "Your email ghost@nobody.com is already exist in the system. You need to sign in first."}

#      it { response.should redirect_to new_user_session_path }
#    end
#  end

#  describe "#logged in user" do
#    context "when user don't have facebook authentication" do
#      before(:each) do
#        stub_env_for_omniauth

#        user = User.create!(:email => "user@example.com", :password => "my_secret")
#        sign_in user

#        get :facebook
#      end

#      it "should add facebook authentication to current user" do
#        user = User.where(:email => "user@example.com").first
#        user.should_not be_nil
#        fb_authentication = user.authentications.where(:provider => "facebook").first
#        fb_authentication.should_not be_nil
#        fb_authentication.uid.should == "1234"
#      end

#      it { should be_user_signed_in }

#      it { response.should redirect_to authentications_path }

#      it { flash[:notice].should == "Facebook is connected with your account."}
#    end

#    context "when user already connect with facebook" do
#      before(:each) do
#        stub_env_for_omniauth

#        user = User.create!(:email => "ghost@nobody.com", :password => "my_secret")
#        user.authentications.create!(:provider => "facebook", :uid => "1234")
#        sign_in user

#        get :facebook
#      end

#      it "should not add new facebook authentication" do
#        user = User.where(:email => "ghost@nobody.com").first
#        user.should_not be_nil
#        fb_authentications = user.authentications.where(:provider => "facebook")
#        fb_authentications.count.should == 1
#      end

#      it { should be_user_signed_in }

#      it { flash[:notice].should == "Signed in successfully." }

#      it { response.should redirect_to tasks_path }

#    end
#  end

#end

#def stub_env_for_omniauth
#  # This a Devise specific thing for functional tests. See https://github.com/plataformatec/devise/issues/closed#issue/608
#  request.env["devise.mapping"] = Devise.mappings[:user]
#  env = { "omniauth.auth" => { "provider" => "facebook", "uid" => "1234", "extra" => { "user_hash" => { "email" => "ghost@nobody.com" } } } }
#  @controller.stub!(:env).and_return(env)
#end

#require 'spec_helper'

#  describe AuthenticationsController do
#    before { @user = Factory(:user) }

#    describe "POST / from facebook" do
#      before do
#        @omniauth = {
#          'uid' => "12345",
#          'provider' => "facebook"
#        }
#        request.env["omniauth.auth"] = @omniauth
#      end

#      context "user logged in" do
#        before do
#          sign_in @user
#        end
#        context "having no authentications" do
#          it "should create authentication " do
#            post :create
#            @user.reload.should have(1).authentication
#          end

#          it "should redirect to user's profile" do
#            post :create
#            response.should redirect_to(edit_user_registration_path(@user))
#          end
#        end

#        context "having facebook authentication" do
#          before { @user.authentications.create!(:provider => "facebook", :uid => "12345")}
#          it "should not create authentication  " do
#            post :create
#            @user.reload.should have(1).authentication
#          end

#          it "should redirect to user's profile" do
#            post :create
#            response.should redirect_to(edit_user_registration_path(@user))
#          end
#        end

#        context "facebook authentication connected to another account" do
#          before do
#            @another_user = Factory(:user)
#            @another_user.authentications.create!(:provider => "facebook", :uid => "12345")
#          end

#          it "should disallow to connect accounts" do
#            post :create
#            @user.reload.should have(0).authentications
#            flash[:error].should == "This facebook account is already connected to another account in our service"
#            response.should redirect_to(edit_user_registration_path(@user))
#          end
#        end
#      end

#      context "user logged out" do
#        context "user has attached authentication", "and logging in" do
#          before { @user.authentications.create!(:provider => "facebook", :uid => "12345") }
#          it "should sign in user" do
#            post :create
#            controller.send(:current_user).should == @user
#          end

#          it "should redirect" do
#            post :create
#            response.should be_redirect
#          end
#        end
#      end
#
#      context "no matching user" do
#        context "no extra credentials given" do
#          before do
#            @user = User.new
#            @user.stub!(:save => false)
#            User.stub!(:new => @user)
#          end

#          it "should apply authentication" do
#            @user.should_receive(:apply_authentication).with(request.env["omniauth.auth"])
#            post :create
#          end

#          it "should save authentication to session" do
#            post :create
#            session[:omniauth].should == @omniauth
#          end

#          it "should redirect to new registration path" do
#            post :create
#            response.should redirect_to(new_user_registration_path)
#          end
#        end

#        context "facebook credentials given" do
#          before { request.env["omniauth.auth"]["user_info"] = {"email" => "example@example.com"} }

#          it "should create user" do
#            -> { post :create }.should change(User, :count).by(1)
#          end

#          it "should sign in created user" do
#            post :create
#            controller.send(:current_user).should_not be_nil
#          end

#          it "should redirect" do
#            post :create
#            response.should be_redirect
#          end
#        end
#      end
#    end
#  end

