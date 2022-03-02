# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Policies
      # Schema and validation rules for Glue {AcaEntities::Policies::Policy} .
      class PolicyContract < Dry::Validation::Contract
        params do
          required(:policy_id).filled(:string)
          required(:enrollment_group_id).filled(:string)
          optional(:qhp_id).maybe(:string)
          optional(:allocated_aptc).maybe(:float)
          optional(:elected_aptc).maybe(:float)
          optional(:applied_aptc).maybe(:float)
          optional(:csr_amt).maybe(:float)
          required(:total_premium_amount).filled(:float)
          required(:total_responsible_amount).filled(:float)
          required(:coverage_start).filled(:date)
          required(:coverage_end).filled(:date)
          required(:coverage_kind).filled(:string)
          optional(:term_for_np).maybe(:bool)
          optional(:rating_area).maybe(:string)
          optional(:service_area).maybe(:string)
          optional(:last_maintenance_date).maybe(:date)
          optional(:last_maintenance_time).maybe(:string)
          optional(:aasm_state).maybe(:string)
          optional(:exchange_subscriber_id).maybe(:string)
          optional(:effectuation_status).maybe(:string)
          optional(:insurance_line_code).maybe(:string)
          optional(:csr_variant).maybe(:string)
          required(:enrollees).array(AcaEntities::Contracts::Enrollees::EnrolleeContract.params)
          # optional(:aptc_maximums).array(AcaEntities::Contracts::Policies::AptcMaximumContract.params)
          # optional(:aptc_credits).array(AcaEntities::Contracts::Policies::AptcCreditContract.params)
        end
      end
    end
  end
end
