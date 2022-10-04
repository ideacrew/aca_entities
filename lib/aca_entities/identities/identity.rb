# frozen_string_literal: true

module AcaEntities
  module Identities
    # A minimal security schema to reference an identity and include authentication and authorization information in a model
    class Identity < Dry::Struct
      # @!attribute [r] id
      # Identity provider-assigned unique identifier
      # @return [String]
      attribute? :id, Types::String.meta(omittable: true)

      # @!attribute [r] name
      # The display name. Usually a concatenation of first and last name, but may also be an arbitrary
      # designator or nickname
      # @return [String]
      attribute :name, Types::String.meta(omittable: false)

      # @!attribute [r] enabled
      # Flag indicating whether this Identity is active
      # @return [Boolean]
      attribute :enabled, Types::Bool.meta(omittable: false)

      # @!attribute [r] time_stamp
      # Date and time when this record was created and last updated
      # @return [AcaEntities::TimeStamp]
      attribute? :time_stamp, AcaEntities::TimeStamp.meta(omittable: true)
    end
  end
end
