require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe Actor do

  it { should be_mongoid_document }
  it { should be_timestamped_document }

  # Model Fields
  it { should have_field(:username).of_type(String).with_default_value_of("") }
  # Devise Confirmable
  it { should have_field(:confirmation_token).of_type(String) }
  it { should have_field(:confirmed_at).of_type(Time) }
  it { should have_field(:confirmation_sent_at).of_type(Time) }
  # Devise Database Authenticable
  it { should have_field(:email).of_type(String).with_default_value_of("") }
  it { should have_field(:encrypted_password).of_type(String).with_default_value_of("") }
  # Devise Encryptable
  it { should have_field(:password_salt).of_type(String).with_default_value_of("") }
  # Devise Lockable
  it { should have_field(:failed_attempts).of_type(Integer).with_default_value_of(0) }
  it { should have_field(:unlock_token).of_type(String) }
  it { should have_field(:locked_at).of_type(Time) }
  # Devise Recoverable
  it { should have_field(:reset_password_token).of_type(String) }
  # Devise Rememberable
  it { should have_field(:remember_token).of_type(String) }
  it { should have_field(:remember_created_at).of_type(Time) }
  # Devise Token Authenticable
  it { should have_field(:authentication_token).of_type(String) }
  # Devise Trackable
  it { should have_field(:sign_in_count).of_type(Integer).with_default_value_of(0) }
  it { should have_field(:current_sign_in_at).of_type(Time) }
  it { should have_field(:last_sign_in_at).of_type(Time) }
  it { should have_field(:current_sign_in_ip).of_type(String) }
  it { should have_field(:last_sign_in_ip).of_type(String) }
  # Refinery Specific
  it { should have_field(:persistence_token).of_type(String) }
  it { should have_field(:perishable_token).of_type(String) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should reference_and_be_referenced_in_many(:roles) }
  it { should reference_many(:plugins) }

  context "devise modules" do
    subject { Actor }
    it { should_not be_confirmable }
    it { should_not be_database_authenticatable }
    it { should_not be_encryptable }
    it { should_not be_lockable }
    it { should_not be_omniauthable }
    it { should_not be_recoverable }
    it { should_not be_registerable }
    it { should_not be_rememberable }
    it { should_not be_timeoutable }
    it { should_not be_token_authenticatable }
    it { should_not be_trackable }
    it { should_not be_validatable }
  end

end

