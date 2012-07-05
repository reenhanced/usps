class USPS::Package < Struct.new(:id, :service, :origin_zip, :destination_zip, :pounds, :ounces, :container, :size)

  @@required_properties = %w{id service origin_zip destination_zip pounds ounces container size}

  def initialize(args)
    args.each_pair { |k, v| send("#{k}=", v) }
    yield self if block_given?

    @@required_properties.each do |prop|
      raise ArgumentError, "#{prop} is required" unless send(prop)
    end
  end
end
