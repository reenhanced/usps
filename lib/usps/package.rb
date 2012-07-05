module USPS

  class Package < Struct.new(:id, :service, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size)

    @@required_properties = %w{id service origin_zip destination_zip pounds ounces container size}

    def initialize(args = {})
      args.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?

      @@required_properties.each do |prop|
        raise ArgumentError, "#{prop} is required" unless send(prop)
      end
    end
  end

  class PackageResponse < Struct.new(:id, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size)

    attr_accessor :postages

    def initialize(properties = {})
      properties.each_pair { |k, v| send("#{k}=", v) }
      yield self if block_given?
    end
  end

  class Postage < Struct.new(:rate, :mail_service, :class_id)
  end

end
