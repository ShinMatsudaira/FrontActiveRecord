require 'date'

class FrontActiveRecord
  def self.define_schema schema_hash
    self.class_variable_set(:@@attributes, schema_hash).freeze
    self.send :attr_accessor, *schema_hash.keys
  end

  def initialize
  end

  def attribute_schema
    self.class.class_variable_get(:@@attributes)
  end

  def fetch 
    #DEBUG
    {
      id:         1,
      name:       'name',
      created_at: '2016-03-05 03:12:17'
    }
  end

  def render_attributes
    Array.new.tap do |array|
      attribute_schema.each do |key, klass|
        value = self.instance_variable_get "@#{key}"
        array << case klass
        when Fixnum, Float then "#{key}: #{value}"
        when DateTime      then "#{key}: #{value.stftime("%Y-%m-%d %H:%M:%S")}"
        else                    "#{key}: '#{value}'"
        end
      end
    end.join(",\n")
  end

  def load
    self.fetch.tap do |record|
      self.attribute_schema.each do |key, klass|
        value = record[key.to_sym]
        value = case klass
        when Float    then value.to_f
        when Fixnum   then value.to_i
        when DateTime then DateTime.parse value
        when NilClass then nil
        else value.to_s
        end
        self.instance_variable_set "@#{key}", value
      end
    end
  end

  def render
    <<-EOS
      function #{self.class}() {};
      #{self.class}.prototype = {
        #{self.render_attributes},
        save: function(){
          alert("saved!");
        },
        destroy: function(){
          alert("destroyed!");
        }
      }
    EOS
  end
end
