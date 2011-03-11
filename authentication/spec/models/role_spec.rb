require 'spec_helper'

Dir[File.expand_path('../../../features/support/factories.rb', __FILE__)].each {|f| require f}

describe Role do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:title).of_type(String) }
  it { should validate_uniqueness_of(:title) }
  it { should reference_and_be_referenced_in_many(:actors) }

end

