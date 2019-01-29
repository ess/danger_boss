require 'danger_boss/entity'
require 'danger_boss/types'

module DangerBoss
  class Alert < Entity
    class Status < Entity
      attribute :state, Types::Strict::String

      attribute :silenced_by,
        Types::Strict::Array.of(
          Types::Strict::String
        )

      attribute :inhibited_by,
        Types::Strict::Array.of(
          Types::Strict::String
        )
    end

    attribute :fingerprint, Types::Strict::String
    attribute :generator_url, Types::Strict::String
    attribute :status, Status

    # Dynamic information
    attribute :receivers,
      Types::Strict::Array.of(Types::Strict::String)

    attribute :annotations,
      Types::Strict::Hash.map(
        Types::Strict::String,
        Types::Strict::String
    )

    attribute :labels,
      Types::Strict::Hash.map(
        Types::Strict::String,
        Types::Strict::String
    )

    # Timestamps
    attribute :starts_at, Types::JSON::Time.meta(omittable: true)
    attribute :updated_at, Types::JSON::Time.meta(omittable: true)
    attribute :ends_at, Types::JSON::Time.meta(omittable: true)
  end
end
