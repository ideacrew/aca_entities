# frozen_string_literal: true

module AcaEntities
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
      #   @option opts [String] :phone_mobile required
      #   @option opts [String] :email required
      #   @option opts [Date] :birthdate required
      #   @option opts [String] :relationship_c required
      #   @return [Dry::Monads::Result]
      class ContactContract < Dry::Validation::Contract
        params do
          required(:hbxid_c).filled(:string)
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:phone_mobile).filled(AcaEntities::Crm::Types::Phone)
          required(:email).filled(AcaEntities::Crm::Types::Email)
          required(:birthdate).filled(AcaEntities::Crm::Types::Dob)
          required(:relationship_c).filled(:string)
        end
      end
    end
  end
end
