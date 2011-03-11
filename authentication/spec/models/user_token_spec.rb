require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe UserToken do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:provider).of_type(String) }
  it { should have_field(:uid).of_type(String) }
  it { should have_field(:token).of_type(String) }
  it { should have_field(:secret).of_type(String) }
  it { should have_field(:omniauth).of_type(Hash) }
  it { should be_referenced_in(:user).as_inverse_of(:user_tokens) }

end

