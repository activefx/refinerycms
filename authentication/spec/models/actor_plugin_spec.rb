require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe ActorPlugin do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:position).of_type(Integer) }
  it { should be_referenced_in(:actor).as_inverse_of(:plugins) }

end

