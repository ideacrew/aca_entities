# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::Person}.
      class PersonContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Hash] :person_name required
        # @option opts [Hash] :person_demographics required
        # @option opts [Hash] :person_health required
        # @option opts [Boolean] :is_active required
        # @option opts [Boolean] :is_disabled optional
        # @option opts [Boolean] :no_dc_address optional
        # @option opts [Boolean] :no_dc_address_reason optional
        # @option opts [Boolean] :is_homeless optional
        # @option opts [Boolean] :is_temporarily_out_of_state optional
        # @option opts [Boolean] :age_off_excluded optional
        # @option opts [Boolean] :is_applying_for_assistance optional
        # @option opts [Array] :person_relationships optional
        # @option opts [Hash] :consumer_role optional
        # @option opts [Hash] :resident_role optional
        # @option opts [Array] :individual_market_transitions optional
        # @option opts [Array] :verification_types optional
        # @option opts [Hash] :broker_role optional
        # @option opts [Array] :broker_agency_staff_roles optional
        # @option opts [Array] :general_agency_staff_roles optional
        # @option opts [Array] :employee_roles optional
        # @option opts [Array] :employer_staff_roles optional
        # @option opts [Array] :addresses optional
        # @option opts [Array] :phones optional
        # @option opts [Array] :emails optional
        # @option opts [Array] :documents optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          optional(:last_ea_action).maybe(:string)
          optional(:external_person_link).maybe(:string)
          optional(:person_id).maybe(:string)
          required(:hbx_id).maybe(:string)
          required(:person_name).hash(AcaEntities::Contracts::People::PersonNameContract.params)
          required(:person_demographics).hash(AcaEntities::Contracts::People::PersonDemographicsContract.params)
          required(:person_health).hash(AcaEntities::Contracts::People::PersonHealthContract.params)
          required(:is_active).maybe(:bool)
          optional(:is_disabled).maybe(:bool)
          optional(:no_dc_address).maybe(:bool)
          optional(:no_dc_address_reason).maybe(:bool)
          optional(:is_homeless).maybe(:bool)
          optional(:is_temporarily_out_of_state).maybe(:bool)
          optional(:age_off_excluded).maybe(:bool)
          optional(:is_applying_for_assistance).maybe(:bool)
          optional(:person_relationships).array(AcaEntities::Contracts::People::PersonRelationshipContract.params)
          optional(:consumer_role).maybe(AcaEntities::Contracts::People::ConsumerRoleContract.params)
          optional(:resident_role).maybe(AcaEntities::Contracts::People::ResidentRoleContract.params)
          optional(:individual_market_transitions).array(AcaEntities::Contracts::Determinations::IndividualMarketTransitionContract.params)
          optional(:verification_types).array(AcaEntities::Contracts::Verifications::VerificationTypeContract.params)
          optional(:user).maybe(AcaEntities::Accounts::Contracts::UserContract.params)
          optional(:broker_role).maybe(AcaEntities::Contracts::Brokers::BrokerRoleContract.params)
          optional(:addresses).array(AcaEntities::Contracts::Locations::AddressContract.params)
          optional(:phones).array(AcaEntities::Contracts::Contacts::PhoneContactContract.params)
          optional(:emails).array(AcaEntities::Contracts::Contacts::EmailContactContract.params)
          optional(:documents).array(AcaEntities::Contracts::Documents::DocumentContract.params)
          optional(:timestamp).hash(TimeStampContract.params)

          # TODO: Add contracts
          # optional(:broker_agency_staff_roles).array(:array)
          # optional(:general_agency_staff_roles).array(:array)
          # optional(:employee_roles).array(:array)
          # optional(:employer_staff_roles).array(:array)
        end
      end
    end
  end
end
