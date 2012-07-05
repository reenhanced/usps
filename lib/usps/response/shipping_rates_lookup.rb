module USPS::Response
  class ShippingRatesLookup < Base
    attr_reader :packages

    def initialize(xml)
      @packages = []
      xml.search('Package').each do |pkg_node|
        postages = pkg_node.search('Postage').map { |postage| parse_postage(postage) }
        @packages << USPS::PackageResponse.new(postages)
      end
    end

    private

    def parse_package(package)
    end

    def parse_postage(postage)
      USPS::Postage.new.tap do |p|
        p.class_id = postage.attr('CLASSID')
        p.mail_service = postage.search('MailService').text
        p.rate = postage.search('Rate').text
      end
    end
  end
end
