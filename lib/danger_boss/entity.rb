require 'dry-struct'
require 'danger_boss/util'

module DangerBoss
  class Entity < Dry::Struct
    input.strict

    # Go programmers are sadists that use camel case field names
    transform_keys {|key| Util.parseltongue(key).to_sym}
  end
end
