# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      module BenchmarkProducts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::BenchmarkProducts::Member}
        class MemberContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [AcaEntities::MagiMedicaid::Contracts::ApplicantReferenceContract] :applicant_reference required
          # @option opts [String] :relationship_with_primary required
          # @option opts [Integer] :age_on_effective_date required
          # @return [Dry::Monads::Result]
          params do
            required(:applicant_reference).filled(::AcaEntities::MagiMedicaid::Contracts::ApplicantReferenceContract.params)
            required(:relationship_with_primary).filled(:string)
            required(:age_on_effective_date).filled(:integer)
          end
        end
      end
    end
  end
end
