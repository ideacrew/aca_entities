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
          optional(:gender).maybe(AcaEntities::Types::BinaryGenderKind)
          optional(:tax_household_id).maybe(:string)
          optional(:relationship_code).maybe(:string)
          optional(:is_subscriber).maybe(:bool)
          optional(:is_tobacco_user).maybe(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)

          # Coerce common alternative gender values to GenderKind type before validating
          before(:value_coercer) do |result|
            # require 'pry'
            # binding.pry
            if result.to_h && result.to_h[:gender]
              parms = result.to_h

              if parms[:gender].present?
                gender_val = 'female' if %w[Female female F f girl woman].include? parms[:gender]
                gender_val = 'male' if %w[Male male M m boy man].include? parms[:gender]
                gender_val ||= parms[:gender]

                result.to_h.merge!({ gender: gender_val }) if %w[female male].include? gender_val
              end
            end
            # Dry::Schema::Result doesn't handle nested values
          rescue TypeError
            puts '      INFO: MemberContract value_coercer received nil gender attribute'
          end
        end
      end
    end
  end
end
