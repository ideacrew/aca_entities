# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for IdentifyingInformation.
    class IdentifyingInformation < Dry::Struct

      attribute :encrypted_ssn, Types::String.optional.meta(omittable: true)
      # Applicant's no_ssn maps to has_ssn.
      attribute :has_ssn, Types::Bool.meta(omittable: false)
    end
  end
end
