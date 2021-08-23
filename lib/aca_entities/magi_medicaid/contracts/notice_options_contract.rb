# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::NoticeOptions}
      class NoticeOptionsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :send_eligibility_notices required
        # @option opts [Boolean] :send_open_enrollment_notices required
        # @return [Dry::Monads::Result]
        params do
          required(:send_eligibility_notices).filled(:bool)
          required(:send_open_enrollment_notices).filled(:bool)
        end
      end
    end
  end
end
