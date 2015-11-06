def attribute(arg, value = nil, &block)
  if arg.is_a?(Hash)
    attribute(arg.keys.first, arg.values.first)
  else
    attr_writer arg

    define_method "#{arg}" do
      if instance_variable_defined?("@#{arg}")
        instance_variable_get("@#{arg}")
      else
        instance_variable_set("@#{arg}", block ? instance_eval(&block) : value)
      end
    end

    define_method "#{arg}?" do
      true if instance_variable_get("@#{arg}")
    end
  end
end
