# frozen_string_literal: true

module AcaEntities
  # Contains classes and modules related to CRM entities.
  module Crm
    module Contracts
      # Schema and validation rules for {AcaEntities::Contact}
      #
      # @!method call(opts)
      #   Validates contact parameters against defined rules.
      #   @param opts [Hash] the parameters to validate using this contract
      #   @option opts [String] :hbxid_c required
      #   @option opts [String] :first_name required
      #   @option opts [String] :last_name required
      #   @option opts [String] :phone_mobile optional
      #   @option opts [String] :email1 optional
      #   @option opts [Date] :birthdate required
      #   @option opts [String] :relationship_c required
      #   @return [Dry::Monads::Result]
      class ContactContract < Dry::Validation::Contract
        params do
          required(:hbxid_c).filled(Types::Coercible::String)
          required(:first_name).filled(Types::Coercible::String)
          required(:last_name).filled(Types::Coercible::String)
          optional(:phone_mobile).maybe(AcaEntities::Crm::Types::Phone)
          optional(:email1).maybe(AcaEntities::Crm::Types::Email)
          required(:birthdate).filled(AcaEntities::Crm::Types::Dob)
          required(:relationship_c).filled(Types::Coercible::String)
        end
      end
    end
  end
end
