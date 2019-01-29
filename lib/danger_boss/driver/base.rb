require 'dry/monads/result'
require 'dry/monads/try'

module DangerBoss
  module Driver
    Error = Class.new(StandardError)
    NotImplemented = Class.new(Error)
    TransportError = Class.new(Error)

    module Base
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Try::Mixin

      def get(path:, params: {})
        raise NotImplemented.new("get is not implemented")
      end
    end
  end
end
