# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class SubjectContract < Dry::Validation::Contract
        params do
          required(:gid).filled(type?: URI)
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:is_primary).filled(:bool)
          required(:determinations).maybe(:hash)
        end

        rule(:determinations) do
          values.to_h[:determinations]
            .each_pair do |determination_key, determination_val|
            result =
              AcaEntities::Eligibilities::Contracts::DeterminationContract.new
                .call(determination_val)
            next unless result.failure?

            key([*path, determination_key]).failure(
              { text: 'error', code: result.errors.to_h }
            )
          end
        end
      end
    end
  end
end
