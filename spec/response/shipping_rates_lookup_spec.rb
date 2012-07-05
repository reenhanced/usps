require 'spec_helper'

describe USPS::Response::ShippingRatesLookup do

  it "should handle test request" do
    response = USPS::Response::ShippingRatesLookup.new(load_xml("shipping_rates_lookup.xml"))
    response.should have(1).packages
    response.packages.first.tap do |p|
      p.should have(5).postages
      p.id.should == '42'
      p.origin_zip.should == '20171'
      p.destination_zip.should == '08540'
      p.pounds.should == '2'
      p.ounces.should == '0'
      p.size.should == 'REGULAR'
    end
  end
end
