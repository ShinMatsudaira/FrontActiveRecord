require_relative '../lib/front_active_record'
require 'pry'

class Test < FrontActiveRecord
  define_schema(
    id:         Fixnum,
    name:       String,
    created_at: DateTime
  )
end

if __FILE__ == $0
  test = Test.new
  test.load #DEBUG

  # p test.inspect
  puts test.render
end
