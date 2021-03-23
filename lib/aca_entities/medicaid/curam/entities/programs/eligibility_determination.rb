# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Programs
        # entity for EligibilityDetermination
        class EligibilityDetermination < Dry::Struct

          attribute :id,             Curam::Identifiers::Id.optional.meta(omittable: true)
          attribute :determined_at,  Types::DateTime.meta(omittable: false)
          attribute :application_id, Curam::Identifiers::Id.optional.meta(omittable: true)
          attribute :variances,      Types::Array.of(Variances::Variance).optional.meta(omittable: true)
          attribute :tax_households, Types::Array.of(TaxHouseholds::TaxHousehold).meta(omittable: false)
        end
      end
    end
  end
end
