# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for IAP Application.
    class Application < Dry::Struct
      attribute :family_reference, AcaEntities::Families::FamilyReference.meta(omittable: false)
      attribute :assistance_year, Types::Integer.meta(omittable: false)
      attribute :years_to_renew, Types::Integer.optional.meta(omittable: true)
      attribute :renewal_consent_through_year, Types::Integer.optional.meta(omittable: true)
      attribute :is_ridp_verified, Types::Bool.optional.meta(omittable: true)
      attribute :is_renewal_authorized, Types::Bool.optional.meta(omittable: true)
      attribute :applicants, Types::Array.of(Applicant).meta(omittable: false)
      attribute :tax_households, Types::Array.of(TaxHousehold).optional.meta(omittable: true)
      attribute :relationships, Types::Array.of(Relationship).optional.meta(omittable: true)
    end
  end
end
