require 'spec_helper'

describe USPS::Response::ShippingRatesLookup do

  it "should handle test request" do
    response = USPS::Response::ShippingRatesLookup.new(load_xml("shipping_rates_lookup.xml"))
    response.should have(1).packages
    response.packages.first.should have(5).postages
  end
end
