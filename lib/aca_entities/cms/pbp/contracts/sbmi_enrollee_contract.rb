# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      module Contracts
        # Schema and validation rules for the {Cms::Pbp::SbmiEnrollee} domain model
        class SbmiEnrolleeContract < Dry::Validation::Contract
          params do
            required(:exchange_assigned_memberId).filled(:string)
            required(:subscriber_indicator).filled(:string)
            optional(:issuer_assigned_memberId).maybe(:string)
            required(:person_last_name).filled(:string)
            optional(:person_first_name).maybe(:string)
            optional(:person_middle_name).maybe(:string)
            optional(:person_name_suffix).maybe(:string)
            required(:birth_date).filled(:date)
            optional(:social_security_number).maybe(:string)
            required(:postal_code).filled(:string)
            optional(:gender_code).maybe(:string)
            optional(:non_covered_subscriberInd).maybe(:string)
            required(:member_start_date).filled(:date)
            required(:member_end_date).filled(:date)
          end
        end
      end
    end
  end
end
