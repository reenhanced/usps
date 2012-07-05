module USPS::Response
  class ShippingRatesLookup < Base
    attr_reader :packages

    def initialize(xml)
      @packages = []
      xml.search('Package').each do |pkg_node|
        @packages << USPS::PackageResponse.new do |p|
          p.postages = pkg_node.search('Postage').map { |postage| parse_postage(postage) }
          p.id = pkg_node.attr('ID')
          p.pounds = pkg_node.search('Pounds').text
          p.ounces = pkg_node.search('Ounces').text
          p.size = pkg_node.search('Size').text
          p.container = pkg_node.search('Container').text
          p.origin_zip = pkg_node.search('ZipOrigination').text
          p.destination_zip = pkg_node.search('ZipDestination').text
        end
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
