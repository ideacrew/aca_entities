# frozen_string_literal: true

module AcaEntities
  module BenefitSponsors
    module BenefitApplications
      # contract for BenefitApplication
      class BenefitApplicationContract < Dry::Validation::Contract

        params do
          optional(:expiration_date).maybe(:date)
          required(:effective_period).filled(type?: Range)
          required(:open_enrollment_period).filled(type?: Range)
          optional(:terminated_on).maybe(:date)
          required(:aasm_state).filled(:symbol)
          optional(:fte_count).maybe(:integer)
          optional(:pte_count).maybe(:integer)
          optional(:msp_count).maybe(:integer)
          optional(:recorded_sic_code).maybe(:string)
          # optional(:predecessor_id).maybe(Types::Bson)
          # required(:recorded_rating_area_id).filled(Types::Bson)
          required(:recorded_service_area_ids).filled(:array)
          # required(:benefit_sponsor_catalog_id).filled(Types::Bson)
          optional(:termination_kind).maybe(:string)
          optional(:termination_reason).maybe(:string)
        end
      end
    end
  end
end