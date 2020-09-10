module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) || [] }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name_history, []) unless instance_variable_get(var_name_history)
        instance_variable_get(var_name_history) << value
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, attribute_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise TypeError, "Type mismatch! Should be #{attribute_class}" unless value.is_a?(attribute_class)

      instance_variable_set(var_name, value)
    end

  end
end
