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
          required(:subscriber_service_area_id).value(:string)
          required(:subscriber_rating_area_id).value(:string)

          required(:subscriber).value(EnrolledMemberContract.params)

          # required(:subscriber).value(:hash)
          optional(:dependents).array(EnrolledMemberContract.params)
          required(:enrollment_elections).array(EnrollmentElectionContract.params)
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
