# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::CitizenshipImmigrationStatusInformation}
      class CitizenshipImmigrationStatusInformationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :citizen_status optional
        # @option opts [Boolean] :is_resident_post_092296 optional
        # @option opts [Boolean] :is_lawful_presence_self_attested optional
        # @return [Dry::Monads::Result]
        params do
          optional(:citizen_status).maybe(Types::CitizenKinds)
          optional(:is_resident_post_092296).maybe(:bool)
          optional(:is_lawful_presence_self_attested).maybe(:bool)
        end
      end
    end
  end
end
