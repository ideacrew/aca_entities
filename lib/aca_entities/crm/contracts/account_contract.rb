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
      #   @option opts [String] :billing_address_city required
      #   @option opts [String] :billing_address_postalcode required
      #   @option opts [String] :billing_address_state required
      #   @option opts [String] :phone_office required
      #   @option opts [String] :raw_ssn_c required
      #   @option opts [Date] :dob_c required
      #   @option opts [String] :enroll_account_link_c optional
      #   @return [Dry::Monads::Result]
      class AccountContract < Dry::Validation::Contract
        params do
          required(:hbxid_c).filled(:string)
          required(:name).filled(:string)
          required(:email1).filled(AcaEntities::Crm::Types::Email)
          required(:billing_address_street).filled(:string)
          required(:billing_address_city).filled(:string)
          required(:billing_address_postalcode).filled(:string)
          required(:billing_address_state).filled(:string)
          required(:phone_office).filled(AcaEntities::Crm::Types::Phone)
          required(:raw_ssn_c).filled(AcaEntities::Crm::Types::SSN)
          required(:dob_c).filled(AcaEntities::Crm::Types::Dob)
          optional(:enroll_account_link_c).maybe(:string)

          required(:contacts).array(AcaEntities::Crm::Contracts::ContactContract.params)
        end
      end
    end
  end
end
