# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::ApplicantReference}
      class ApplicantReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :first_name required
        # @option opts [String] :last_name required
        # @option opts [Date] :dob required
        # @option opts [String] :person_hbx_id required
        # @option opts [String] :encrypted_ssn optional
        # @return [Dry::Monads::Result]
        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:dob).filled(:date)
          required(:person_hbx_id).filled(:string)
          optional(:encrypted_ssn).maybe(:string)
        end
      end
    end
  end
end
