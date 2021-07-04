# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for CitizenshipImmigrationStatusInformation.
    class CitizenshipImmigrationStatusInformation < Dry::Struct

      attribute :citizen_status, Types::CitizenKinds.optional.meta(omittable: true)
      attribute :is_resident_post_092296, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] is_lawful_presence_self_attested
      # Does the non-citizen applicant claim to be in the state legally?
      # @return [Bool]
      attribute :is_lawful_presence_self_attested, Types::Bool.optional.meta(omittable: true)
    end
  end
end
