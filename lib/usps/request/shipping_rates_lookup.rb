module USPS::Request

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
        raise ArgumentError, 'A shipping rate lookup requires at least one package (USPS::Package)'
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
