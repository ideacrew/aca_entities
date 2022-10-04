# frozen_string_literal: true

module AcaEntities
  module People
    module Contracts
      # Schema and validation rules for {AcaEntities::People::Person}.
      class PersonContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [AcaEntities::People::Contracts::PersonNameContract] :person_name required
        # @option opts [AcaEntities::People::Contracts::PersonDemographicsContract] :person_demographics required
        # @option opts [AcaEntities::People::Contracts::PersonHealthContract] :person_health required
        # @option opts [Boolean] :is_active required
        # @option opts [Boolean] :is_disabled optional
        # @option opts [Boolean] :no_dc_address optional
        # @option opts [Boolean] :no_dc_address_reason optional
        # @option opts [Boolean] :is_homeless optional
        # @option opts [Boolean] :is_temporarily_out_of_state optional
        # @option opts [Boolean] :age_off_excluded optional
        # @option opts [Boolean] :is_applying_for_assistance optional
        # @option opts [Array] :person_relationships optional
        # @option opts [AcaEntities::People::Contracts::ConsumerRoleContract] :consumer_role optional
        # @option opts [AcaEntities::People::Contracts::ResidentRoleContract] :resident_role optional
        # @option opts [Array<AcaEntities::Determinations::Contracts::IndividualMarketTransitionContract>] :individual_market_transitions optional
        # @option opts [Array<AcaEntities::Contracts::Verifications::VerificationTypeContract>] :verification_types optional
        # @option opts [AcaEntities::Brokers::Contracts::BrokerRoleContract] :broker_role optional
        # @option opts [Array] :broker_agency_staff_roles optional
        # @option opts [Array] :general_agency_staff_roles optional
        # @option opts [Array] :employee_roles optional
        # @option opts [Array] :employer_staff_roles optional
        # @option opts [Array] :addresses optional
        # @option opts [Array] :phones optional
        # @option opts [Array] :emails optional
        # @option opts [Array] :documents optional
        # @option opts [AcaEntities::Accounts::Account] :account optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          optional(:last_ea_action).maybe(:string)
          optional(:external_person_link).maybe(:string)
          optional(:person_id).maybe(:string)
          required(:hbx_id).maybe(:string)
          required(:person_name).hash(AcaEntities::People::Contracts::PersonNameContract.params)
          required(:person_demographics).hash(AcaEntities::People::Contracts::PersonDemographicsContract.params)
          required(:person_health).hash(AcaEntities::People::Contracts::PersonHealthContract.params)
          required(:is_active).maybe(:bool)
          optional(:is_disabled).maybe(:bool)
          optional(:no_dc_address).maybe(:bool)
          optional(:no_dc_address_reason).maybe(:bool)
          optional(:is_homeless).maybe(:bool)
          optional(:is_temporarily_out_of_state).maybe(:bool)
          optional(:age_off_excluded).maybe(:bool)
          optional(:is_applying_for_assistance).maybe(:bool)
          optional(:person_relationships).array(AcaEntities::People::Contracts::PersonRelationshipContract.params)
          optional(:consumer_role).maybe(AcaEntities::People::Contracts::ConsumerRoleContract.params)
          optional(:resident_role).maybe(AcaEntities::People::Contracts::ResidentRoleContract.params)
          optional(:individual_market_transitions).array(
            AcaEntities::Determinations::Contracts::IndividualMarketTransitionContract.params
          )
          optional(:verification_types).array(AcaEntities::Contracts::Verifications::VerificationTypeContract.params)
          optional(:user).maybe(AcaEntities::Accounts::Contracts::UserContract.params)
          optional(:account).maybe(AcaEntities::Accounts::Contracts::AccountContract.params)
          optional(:broker_role).maybe(AcaEntities::Brokers::Contracts::BrokerRoleContract.params)
          optional(:addresses).array(AcaEntities::Contracts::Locations::AddressContract.params)
          optional(:phones).array(AcaEntities::Contracts::Contacts::PhoneContactContract.params)
          optional(:emails).array(AcaEntities::Contracts::Contacts::EmailContactContract.params)
          optional(:documents).array(AcaEntities::Documents::Contracts::DocumentContract.params)
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
