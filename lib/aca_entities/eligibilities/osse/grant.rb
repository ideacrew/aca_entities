# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    module Osse
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
        attribute :description?, Types::String.optional.meta(omittable: true)

        # @!attribute [r] key
        # Type of grant, for example cost sharing grant, employer contribution grant
        # or osse premium credit
        # @return [String]
        attribute :key, Types::String.meta(omittable: false)

        # @!attribute [r] value
        # Value can be csr, aptc or employer contribution
        # csr is a percentage, aptc is a $ amount, employer contribution, enrollment ratio
        # @return [Dry::Struct]
        attribute :value, AcaEntities::Eligibilities::Osse::Value

        # @!attribute [r] start_on
        # Start date for the grant
        # @return [Date]
        attribute :start_on, Types::Date.meta(omittable: false)

        # @!attribute [r] end_on
        # End date for the grant
        # @return [Date]
        attribute :end_on, Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
