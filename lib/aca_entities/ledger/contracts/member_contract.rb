# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Member}
      class MemberContract < Contract
        params do
          optional(:id).value(:string)
          required(:hbx_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:subscriber_hbx_id).filled(:string)
          optional(:insurer_assigned_subscriber_id).filled(:string)
          required(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:ssn).maybe(:string)
          optional(:dob).maybe(:date)
          optional(:gender).maybe(AcaEntities::Types::GenderKind)
          optional(:tax_household_id).maybe(:string)
          optional(:relationshihp_code).maybe(:string)
          optional(:is_tobacco_user).maybe(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)

          # Coerce common alternative gender values to GenderKind type before validating
          before(:value_coercer) do |result|
            parms = result.to_h

            if parms.key?(:gender) && !parms[:gender].nil?
              # require 'pry'
              # binding.pry
              gender_val = 'Female' if %w[Female f female girl woman].include? parms[:gender]
              gender_val = 'Male' if %w[Male m male boy man].include? parms[:gender]
              gender_val ||= parms[:gender]

              result.to_h.merge!({ gender: gender_val }) if %w[Female Male].include? gender_val
            end
          end
        end
      end
    end
  end
end
