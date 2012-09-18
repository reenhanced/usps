require 'spec_helper'

describe USPS::Response::InternationalShippingRatesLookup do

  it "correctly parses a USPS IntlRateV2 XML response" do
    response = USPS::Response::InternationalShippingRatesLookup.new(load_xml("international_shipping_rates_lookup.xml"))
    response.should have(1).packages
    response.packages.first.tap do |package|
      package.id.should == '3'
      package.should have(4).services

      package.services[0].tap do |gxg|
        gxg.id.should          == '12'
        gxg.rate.should        == '197.00'
        gxg.description.should =~ /USPS GXG/
      end

      package.services[1].tap do |express|
        express.id.should          == '1'
        express.rate.should        == '73.45'
        express.description.should =~ /Express Mail/
      end
    end
  end
end
