# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::Enrollment} entity
      class EnrollmentContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:subscriber).value(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          optional(:spouse).maybe(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          optional(:dependents).array(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          optional(:survivor).maybe(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)

          # use tax_household_groups in MTHH scenario
          optional(:tax_household_groups).array(AcaEntities::Contracts::Households::TaxHouseholdGroupContract.params)

          optional(:total_premium).maybe(AcaEntities::Types::Money)
          optional(:total_premium_adjustments).maybe(AcaEntities::Types::Money)
          optional(:total_responsible_premium).maybe(AcaEntities::Types::Money)

          required(:start_on).value(:date)
          optional(:end_on).maybe(AcaEntities::Types::DateOrNil)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)

          # before(:value_coercer) do |result|
          #   # result = validate_nested_contract(:subscriber, EnrolledMemberContract)
          #   validated_vals = validate_subscriber(:subscriber, EnrolledMemberContract, result.to_h)
          #   result.to_h.merge(validated_vals.to_h).compact
          # end

          # def validate_subscriber(key, contract_klass, values)
          #   key_name = key.to_s
          #   value = values[key_name.to_sym]

          #   # require 'pry'
          #   # binding.pry
          #   AcaEntities::InsurancePolicies::Contract.validate_nested_contract(key_name, contract_klass, value)
          # end
        end

        # rule(:tax_household_groups, :tax_household) do
        #   if values[:tax_household_groups].blank? && values[:tax_household].blank?
        #     key.failure('tax_household or tax_houshold_group must be present')
        #   end
        # end

        # rule(:subscriber).validate(nested_contract: EnrolledMemberContract)
        # rule(:subscriber) do
        #   # validate_nested_contract(EnrolledMemberContract)
        #   # require 'pry'
        #   # binding.pry
        #   return unless key?
        #   contract_klass = EnrolledMemberContract

        #   key_name = keys.first.to_s
        #   value = values[key_name.to_sym]
        #   if value.is_a?(Hash)
        #     result = contract_klass.new.send(:call, value)
        #     if result&.failure?
        #       key.failure(text: "invalid #{key_name}", error: result.errors.to_h)
        #     else
        #       values[key_name] = result.to_h
        #     end
        #   else
        #     key.failure(text: "invalid #{key_name}. Expected a hash.")
        #   end
        # end
      end
    end
  end
end
