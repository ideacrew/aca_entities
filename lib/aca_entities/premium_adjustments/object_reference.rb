# frozen_string_literal: true

module AcaEntities
  module PremiumCredits
    # Cv3 Entity for GroupPremiumCredit
    # AcaEntities::PremiumCredits::Contracts::GroupContract
    class ObjectReference < Dry::Struct

      # @!attribute [r] identifier
      # Unique key for this entity.
      # @return [String]
      attribute :identifier, Types::String.optional.meta(omittable: true)

      # @!attribute [r] label
      # Class name of the object
      # @return [String]
      attribute :label, Types::String.optional.meta(omittable: true)
    end
  end
end
