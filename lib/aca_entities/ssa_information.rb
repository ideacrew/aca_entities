# frozen_string_literal: true

module AcaEntities
  # Entity for SsaInformation.
  class SsaInformation < Dry::Struct

    # Default is true unless SSA confirms that the individual is deceased.
    attribute :is_person_alive,             Types::Bool.optional.meta(omittable: true)

    # Switch indicating if SSA has prisoner data on file that can be released.
    attribute :is_person_incarcerated,      Types::Bool.optional.meta(omittable: true)
    attribute :prisoner_confinement_date,   Types::Date.optional.meta(omittable: true)
    attribute :prison_name,                 Types::String.optional.meta(omittable: true)
    attribute :prison_address,              Types::String.optional.meta(omittable: true)

    # Response Code received by SSA indicating if the combination of
    # SSN, First Name, Middle Name, Last Name, and DOB were verified.
    attribute :ssn_verification_indicator,  Types::Bool.optional.meta(omittable: true)
  end
end
