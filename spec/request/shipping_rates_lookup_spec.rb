require 'spec_helper'

describe USPS::Request::ShippingRatesLookup do
  it "should be using the proper USPS api settings" do
    USPS::Request::ShippingRatesLookup.tap do |klass|
      klass.secure.should be_false
      klass.api.should == 'RateV4'
      klass.tag.should == 'RateV4Request'
    end
  end

  it "requires at least one package" do
    expect {
      request = USPS::Request::ShippingRatesLookup.new
    }.to raise_exception(ArgumentError)
  end

  it "should be able to build a proper request" do
    request = USPS::Request::ShippingRatesLookup
    pending
  end
end
