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
    USPS.username = '591REENH7607'
    package = USPS::Package.new do |p|
      p.id = "42"
      p.service = "ALL"
      p.origin_zip = "20171"
      p.destination_zip = "08540"
      p.pounds = 5
      p.ounces = 4
      p.container = 'VARIABLE'
      p.size = 'LARGE'
    end
    request = USPS::Request::ShippingRatesLookup.new(package)
    request.send!
  end
end
