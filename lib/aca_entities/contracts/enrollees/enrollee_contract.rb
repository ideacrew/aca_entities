# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollees
      # Schema and validation rules for Glue {AcaEntities::Enrollees::Enrollee} .
      class EnrolleeContract < Dry::Validation::Contract
        params do
          required(:enrollee_demographics).filled(AcaEntities::Contracts::Enrollees::EnrolleeDemographicsContract.params)
          required(:first_name).filled(:string)
          optional(:middle_name).maybe(:string)
          required(:last_name).filled(:string)
          optional(:name_suffix).maybe(:string)
          required(:hbx_member_id).filled(:string)
          required(:premium_amount).filled(:float)
          required(:coverage_start).filled(:date)
          required(:coverage_end).filled(:date)
          optional(:coverage_status).maybe(:string)
          required(:relationship_status_code).filled(:string)
          optional(:issuer_assigned_member_id).maybe(:string)
          optional(:issuer_assigned_policy_id).maybe(:string)
          required(:is_subscriber).filled(:bool)
          required(:is_responsible_party).filled(:bool)
          optional(:addresses).array(AcaEntities::Contracts::Locations::AddressContract.params)
          optional(:phones).array(AcaEntities::Contracts::Contacts::PhoneContactContract.params)
          optional(:emails).array(AcaEntities::Contracts::Contacts::EmailContactContract.params)
          optional(:segments).array(AcaEntities::Contracts::Enrollees::SegmentContract.params)
        end
      end
    end
  end
end
