module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation.each do |validation_name, args|
          send(validation_name.to_s, instance_variable_get("@#{args[:name]}".to_sym), args[:condition])
        end
      end
    end

    def valid?
      !!validate!
    rescue ArgumentError, TypeError
      false
    end

    private

    def presence(var, _arg)
      raise ArgumentError, "Can't be blank" if var.is_a?(String) && var.empty?
      raise ArgumentError, "Can't be blank" if var.nil?
    end

    def format(var, format)
      raise ArgumentError, 'Format error' if var !~ format
    end

    def type(var, type)
      raise TypeError, "Type error. Should be #{type}" unless var.is_a?(type)
    end
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type_of_validation, condition = '')
      self.validations ||= []
      validations << { type_of_validation => { name: name, condition: condition } }
    end
  end


end