module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}".to_sym)
        send("validate_#{validation[:type]}", value, validation[:condition])
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError, TypeError
      false
    end

    private

    def validate_presence(var, _arg)
      raise ArgumentError, "Can't be blank" if var.nil? || var.empty?
    end

    def validate_format(var, format)
      raise ArgumentError, 'Format error' if var !~ format
    end

    def validate_type(var, type)
      raise TypeError, "Type error. Should be #{type}" unless var.is_a?(type)
    end
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type_of_validation, condition = '')
      self.validations ||= []
      validations << { name: name, condition: condition, type: type_of_validation }
    end
  end
end
