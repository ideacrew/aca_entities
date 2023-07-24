# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      module Contracts
        # Schema and validation rules for the {Cms::Pbp::SbmiPolicy} domain model
        class SbmiPolicyContract < Dry::Validation::Contract
          params do
            required(:record_control_number).filled(:integer)
            required(:qhp_id).filled(:string)
            required(:rating_area).filled(:string)
            required(:exchange_policy_id).filled(:string)
            required(:exchange_subscriber_id).filled(:string)
            optional(:issuer_policy_id).maybe(:string)
            optional(:issuer_subscriber_id).maybe(:string)
            required(:coverage_start).filled(:date)
            required(:coverage_end).filled(:date)
            required(:effectuation_status).filled(:string)
            required(:insurance_line_code).filled(:string)
            optional(:coverage_household).array(AcaEntities::Cms::Pbp::Contracts::SbmiEnrolleeContract.params)
            optional(:financial_loops).array(AcaEntities::Cms::Pbp::Contracts::FinancialInformationContract.params)
          end
        end
      end
    end
  end
end

