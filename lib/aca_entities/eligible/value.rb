# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligible
    # A value can be cost sharing credit, employer contribution percentage
    # or osse premium credit
    class Value < Dry::Struct
      # @!attribute [r] title
      # Value title
      # @return [String]
      attribute :title, Types::String.meta(ommitable: false)

      # @!attribute [r] description
      # Value description
      # @return [String]
      attribute :description?, Types::String.optional.meta(ommitable: true)

      # @!attribute [r] key
      # Type of grant, for example cost sharing, employer contribution
      # or osse premium credit
      # @return [String]
      attribute :key, Types::Symbol.meta(ommittable: false)
    end
  end
end
