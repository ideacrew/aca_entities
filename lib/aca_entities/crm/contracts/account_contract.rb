# frozen_string_literal: true

module AcaEntities
  # Contains classes and modules related to CRM entities.
  module Crm
    module Contracts
      # Schema and validation rules for {AcaEntities::Account}
      #
      # @!method call(opts)
      #   Validates account parameters against defined rules.
      #   @param opts [Hash] the parameters to validate using this contract
      #   @option opts [String] :hbxid_c required
      #   @option opts [String] :name required
      #   @option opts [String] :dob_c required
      #   @option opts [String] :rawssn_c optional
      #   @option opts [String] :raw_ssn_c optional
      #   @option opts [String] :email1 optional
      #   @option opts [String] :phone_office optional
      #   @option opts [String] :billing_address_street optional
      #   @option opts [String] :billing_address_street2 optional
      #   @option opts [String] :billing_address_street3 optional
      #   @option opts [String] :billing_address_street4 optional
      #   @option opts [String] :billing_address_city optional
      #   @option opts [String] :billing_address_postalcode optional
      #   @option opts [String] :billing_address_state optional
      #   @option opts [String] :enroll_account_link_c optional
      #   @option opts [Array<AcaEntities::Crm::Contracts::ContactContract>] :contacts required
      #   @return [Dry::Monads::Result]
      class AccountContract < Dry::Validation::Contract
        params do
          required(:hbxid_c).filled(Types::Coercible::String)
          required(:name).filled(Types::Coercible::String)
          required(:dob_c).filled(AcaEntities::Crm::Types::Dob)

          optional(:rawssn_c).maybe(AcaEntities::Crm::Types::SSN)
          optional(:raw_ssn_c).maybe(AcaEntities::Crm::Types::SSN)

          optional(:email1).maybe(AcaEntities::Crm::Types::Email)
          optional(:phone_office).maybe(AcaEntities::Crm::Types::Phone)

          optional(:billing_address_street).maybe(Types::Coercible::String)
          optional(:billing_address_street2).maybe(Types::Coercible::String)
          optional(:billing_address_street3).maybe(Types::Coercible::String)
          optional(:billing_address_street4).maybe(Types::Coercible::String)
          optional(:billing_address_city).maybe(Types::Coercible::String)
          optional(:billing_address_postalcode).maybe(Types::Coercible::String)
          optional(:billing_address_state).maybe(Types::Coercible::String)

          optional(:enroll_account_link_c).maybe(Types::Coercible::String)

          required(:contacts).array(AcaEntities::Crm::Contracts::ContactContract.params)
        end
      end
    end
  end
end
