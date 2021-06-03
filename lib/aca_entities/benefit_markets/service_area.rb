# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets ServiceArea
    class ServiceArea < Dry::Struct

      attribute :active_year,                Types::Strict::Integer.meta(omittable: false)
      attribute :issuer_provided_title,      Types::Strict::String.meta(omittable: false)
      attribute :issuer_provided_code,       Types::Strict::String.meta(omittable: false)
      attribute :issuer_profile_reference,   AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)
      attribute :issuer_hios_id,             Types::String.optional.meta(omittable: true)
      attribute :county_zip_ids,             Types::Array.optional.meta(omittable: true)
      attribute :covered_states,             Types::Strict::Array.meta(omittable: false)

    end
  end
end