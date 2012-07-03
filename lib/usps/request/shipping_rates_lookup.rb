module USPS::Request

  class Package
    attr_accessor :id
  end

  class ShippingRatesLookup < Base
    config(
      :api => 'RateV4',
      :tag => 'RateV4Request',
      :secure => false,
      :response => USPS::Response::ShippingRatesLookup
    )

    def initialize(*packages)
      @packages = packages.flatten
      if @packages.none?
        raise ArgumentError, 'at most 5 addresses can be verified at a time'
      end
    end

    def build
      super do |xml|
        @packages.each do |package|
          xml.Package :ID => package.id do
            xml.Service package.service
            xml.ZipOrigination '20171'
            xml.ZipDestination '08540'
            xml.Pounds 2
            xml.Ounces 0
            xml.Container 'VARIABLE'
            xml.Size 'REGULAR'
          end
        end
      end
    end

  end
end
