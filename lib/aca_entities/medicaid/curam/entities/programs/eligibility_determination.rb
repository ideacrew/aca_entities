# frozen_string_literal: true

module Ehs
  class Programs::EligibilityDetermination < Dry::Struct

    attribute :id,             Ehs::Identifiers::Id.optional.meta(omittable: true)
    attribute :determined_at,  Types::DateTime.meta(omittable: false)
    attribute :application_id, Ehs::Identifiers::Id.optional.meta(omittable: true)
    attribute :variances,      Types::Array.of(Variances::Variance).optional.meta(omittable: true)
    attribute :tax_households, Types::Array.of(TaxHouseholds::TaxHousehold).meta(omittable: false)
  end
end
