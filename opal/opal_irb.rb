class OpalIrb
  def irb_vars
    %x|irbVars = [];
       for(variable in Opal.irb_vars) {
         if(Opal.irb_vars.hasOwnProperty(variable)) {
            irbVars.push([variable, Opal.irb_vars[variable]])
         }
       };
       irbVars|
  end

end

# monkey patch object to get some stuff we want
class Object
  def irb_instance_variables
    filtered = ["_id", "constructor", "toString"]
    instance_variables.reject {|var| filtered.include?(var)}.sort
  end

  def irb_instance_var_values
    irb_instance_variables.map {|var_name| [var_name, instance_variable_get("@#{var_name}")]}
  end
end

# test class
class Foo
  def initialize
    @a = "a"
    @b = "b"
  end
end
