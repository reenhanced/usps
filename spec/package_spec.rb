require 'spec_helper'

describe USPS::Package do
  it "can be initialized with a hash" do
    package = USPS::Package.new :service => 'EXPRESS'
    package.service.should == 'EXPRESS'
  end
end
