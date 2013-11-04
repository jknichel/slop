module Slop
  class Option

    attr_reader :builder, :attributes, :type
    attr_writer :writer
    attr_accessor :short, :long, :description, :block, :count, :argument

    def initialize(builder, attributes = {}, &block)
      @builder     = builder
      @attributes  = attributes
      @short       = attributes[:short]
      @long        = attributes[:long]
      @description = attributes[:description]
      @block       = block
      @argument    = nil
      @value       = nil
      @count       = 0
      @type        = Type.from_name(attributes[:type]).new(builder)
      @attributes  = @type.option_config.merge(@attributes)
    end

    def expects_argument?
      attributes[:expects_argument]
    end

    def value
      @value || @argument || attributes[:default]
    end

    def run_block
      @value = type.call(@argument)
      block.call(@value) if block
    end

  end
end
