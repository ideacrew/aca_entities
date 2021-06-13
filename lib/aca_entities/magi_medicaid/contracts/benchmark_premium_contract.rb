# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::BenchmarkPremium}
      class BenchmarkPremiumContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Array] :health_only_lcsp_premiums required
        # @option opts [Array] :health_only_slcsp_premiums required
        # @option opts [Array] :health_and_dental_slcsp_premiums required
        # @option opts [Array] :health_and_ped_dental_slcsp_premiums required
        # @return [Dry::Monads::Result]
        params do
          required(:health_only_lcsp_premiums).array(AcaEntities::MagiMedicaid::Contracts::MemberPremiumContract.params)
          required(:health_only_slcsp_premiums).array(AcaEntities::MagiMedicaid::Contracts::MemberPremiumContract.params)
          optional(:health_and_dental_slcsp_premiums).array(AcaEntities::MagiMedicaid::Contracts::MemberPremiumContract.params)
          optional(:health_and_ped_dental_slcsp_premiums).array(AcaEntities::MagiMedicaid::Contracts::MemberPremiumContract.params)
        end
      end
    end
  end
end
