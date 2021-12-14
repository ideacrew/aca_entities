# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class DeterminationContract < Dry::Validation::Contract
        params { required(:determinations).value(:hash) }

        rule(:determinations) do
          values.to_h[:determinations].each_pair do |eligibility_key, eligibility_val|
            result = AcaEntities::Eligibilities::Contracts::EligibilityContract.new.call(eligibility_val)

            next unless result.failure?
            # binding.irb
            result.errors.to_h.each do |path, message|
              key([eligibility_key, eligibility_val.keys.first, *path]).failure(text: message)
            end
          end
        end
      end
    end
  end
end
