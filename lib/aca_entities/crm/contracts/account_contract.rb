# frozen_string_literal: true

module AcaEntities
  module Crm
    module Contracts
      # Schema and validation rules for {AcaEntities::Account}
      #
      # @!method call(opts)
      #   Validates account parameters against defined rules.
      #   @param opts [Hash] the parameters to validate using this contract
      #   @option opts [String] :hbxid_c required
      #   @option opts [String] :name required
      #   @option opts [String] :email1 required
      #   @option opts [String] :billing_address_street required
      #   @option opts [String] :billing_address_street2 optional
      #   @option opts [String] :billing_address_street3 optional
      #   @option opts [String] :billing_address_street4 optional
      #   @option opts [String] :billing_address_city required
      #   @option opts [String] :billing_address_postalcode required
      #   @option opts [String] :billing_address_state required
      #   @option opts [String] :phone_office required
      #   @option opts [String] :rawssn_c required
      #   @option opts [String] :raw_ssn_c required
      #   @option opts [Date] :dob_c required
      #   @option opts [String] :enroll_account_link_c optional
      #   @return [Dry::Monads::Result]
      class AccountContract < Dry::Validation::Contract
        params do
          required(:hbxid_c).filled(Types::Coercible::String)
          required(:name).filled(Types::Coercible::String)
          optional(:email1).maybe(AcaEntities::Crm::Types::Email)
          required(:billing_address_street).filled(Types::Coercible::String)
          optional(:billing_address_street2).maybe(Types::Coercible::String)
          optional(:billing_address_street3).maybe(Types::Coercible::String)
          optional(:billing_address_street4).maybe(Types::Coercible::String)
          required(:billing_address_city).filled(Types::Coercible::String)
          required(:billing_address_postalcode).filled(Types::Coercible::String)
          required(:billing_address_state).filled(Types::Coercible::String)
          optional(:phone_office).maybe(AcaEntities::Crm::Types::Phone)
          optional(:rawssn_c).maybe(AcaEntities::Crm::Types::SSN)
          required(:raw_ssn_c).filled(AcaEntities::Crm::Types::SSN)
          required(:dob_c).filled(AcaEntities::Crm::Types::Dob)
          optional(:enroll_account_link_c).maybe(Types::Coercible::String)

          required(:contacts).array(AcaEntities::Crm::Contracts::ContactContract.params)
        end
      end
    end
  end
end
