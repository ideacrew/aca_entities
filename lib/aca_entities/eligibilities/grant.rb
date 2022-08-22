# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A grant can be cost sharing grant, employer contribution grant
    # or osse premium credit
    class Grant < Dry::Struct
      # @!attribute [r] title
      # Grant title
      # @return [String]
      attribute :title, Types::String.meta(omittable: false)

      # @!attribute [r] description
      # Grant description
      # @return [String]
      attribute :description, Types::String.optional.meta(omittable: true)

      # @!attribute [r] key
      # Type of grant, for example cost sharing grant, employer contribution grant
      # or osse premium credit
      # @return [String]
      attribute :key, AcaEntities::Eligibilities::Types::GrantType.meta(omittable: false)

      # @!attribute [r] value
      # Value can be csr, aptc
      # csr is a percentage, aptc is a amount
      # @return [Dry::Struct]
      attribute :value, Types::Float.meta(omittable: false)

      # @!attribute [r] start_on
      # Start date for the grant
      # @return [Date]
      attribute :start_on, Types::Date.meta(omittable: false)

      # @!attribute [r] end_on
      # End date for the grant
      # @return [Date]
      attribute :end_on, Types::Date.meta(omittable: false)

      # @!attribute [r] members
      # Members receiving the grant
      # @return array of [String]
      attribute :members, Types::Array.of(Types::String).optional.meta(omittable: true)
    end
  end
end