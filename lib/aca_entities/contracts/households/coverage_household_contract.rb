# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::CoverageHousehold}
      class CoverageHouseholdContract < AcaEntities::Contracts::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_date optional
        # @option opts [Date] :end_date optional
        # @option opts [Boolean] :is_immediate_family required
        # @option opts [Boolean] :is_determination_split_household optional
        # @option opts [String] :aasm_state optional
        # @option opts [Date] :submitted_at optional
        # @option opts [Hash] :coverage_household_members required
        # @option opts [Hash] :broker_agency optional
        # @option opts [Hash] :broker_role optional
        # @return [Dry::Monads::Result]
        params do
          optional(:start_date).maybe(:date)
          optional(:end_date).maybe(:date)
          required(:is_immediate_family).filled(:bool)
          optional(:is_determination_split_household).maybe(:bool)
          optional(:aasm_state).maybe(:string)
          optional(:submitted_at).maybe(:date)
          required(:coverage_household_members).maybe(:array)
          optional(:broker_role_reference).hash(AcaEntities::Contracts::Brokers::BrokerRoleReferenceContract.params)
          optional(:broker_agency_reference).hash(AcaEntities::Contracts::Organizations::BrokerAgencyProfileReferenceContract.params)
        end

        rule(:coverage_household_members).each do |index:|
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::CoverageHouseholdMemberContract.new.call(value)
              if result&.failure?
                key([:coverage_household_members, index]).failure(text: 'invalid coverage_household_members',
                                                                  error: result.errors.to_h)
              end
            else
              key([:coverage_household_members, index]).failure(text: 'invalid coverage_household_memberss. Expected a hash.')
            end
          end
        end
      end
    end
  end
end





