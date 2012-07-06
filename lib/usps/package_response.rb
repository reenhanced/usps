module USPS

  class PackageResponse < Struct.new(:id, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size)

    attr_accessor :postages

    def initialize(properties = {})
      properties.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?
    end

    class Postage < Struct.new(:rate, :mail_service, :class_id)
    end

  end

end
