# frozen_string_literal: true

module AcaEntities
  module People
    # Class AliveStatus
    #
    # This class represents the alive status of a person.
    class AliveStatus < Dry::Struct
      # @!attribute [r] alive_evidence
      #   @return [AcaEntities::Eligibilities::Evidence, nil] the evidence of being alive
      #   @note This attribute is optional and can be omitted.
      attribute :alive_evidence, AcaEntities::Eligibilities::Evidence.optional.meta(omittable: true)

      # @!attribute [r] is_deceased
      #   @return [Types::Bool, nil] the deceased status of a person
      #   @note This attribute is optional and can be omitted.
      attribute :is_deceased,    Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] date_of_death
      #   @return [Types::Date, nil] the date of death of a person
      #   @note This attribute is optional and can be omitted.
      attribute :date_of_death,  Types::Date.optional.meta(omittable: true)
    end
  end
end
