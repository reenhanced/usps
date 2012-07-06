require 'spec_helper'

describe USPS::Request::ShippingRatesLookup do
  it "uses the RateV4 API settings" do
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

  it "builds a valid XML request for USPS RateV4" do
    package             = USPS::Package.new do |p|
      p.id              = "42"
      p.service         = "ALL"
      p.origin_zip      = "20171"
      p.destination_zip = "08540"
      p.pounds          = 5
      p.ounces          = 4
      p.container       = 'VARIABLE'
      p.size            = 'LARGE'
    end
    request = USPS::Request::ShippingRatesLookup.new(package).build
    xml = Nokogiri::XML.parse(request)

    xml.search('Package').count.should == 1

    p1 = xml.search('Package').first
    p1.attr('ID').should                    == "42"
    p1.search('Service').text.should        == 'ALL'
    p1.search('ZipOrigination').text.should == '20171'
    p1.search('ZipDestination').text.should == '08540'
    p1.search('Pounds').text.should         == '5'
    p1.search('Ounces').text.should         == '4'
    p1.search('Container').text.should      == 'VARIABLE'
    p1.search('Size').text.should           == 'LARGE'
  end
end
