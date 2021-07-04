# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Locations
      # Contract for ServiceArea
      class ServiceAreaContract < Dry::Validation::Contract

        params do
          required(:active_year).filled(:integer)
          required(:issuer_provided_title).filled(:string)
          required(:issuer_provided_code).filled(:string)
          required(:issuer_profile_reference).maybe(AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.params)
          optional(:issuer_hios_id).maybe(:string)
          optional(:county_zip_ids).maybe(:array)
          required(:covered_states).array(:string)
        end

      end
    end
  end
end