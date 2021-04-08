# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::EligibilityResponse}
        class EligibilityResponseContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Date] :determination_date required
          # @option opts [Array] :applicants required
          # @return [Dry::Monads::Result]
          params do
            required(:determination_date).filled(:date)
            required(:applicants).array(ApplicantContract.params)
          end
        end
      end
    end
  end
end
