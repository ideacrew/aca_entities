# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for { Subject }
      class SubjectContract < Dry::Validation::Contract
        params do
          required(:gid).filled(type?: URI)
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:is_primary).filled(:bool)
          required(:eligibility_states).maybe(:hash)
        end

        rule(:eligibility_states) do
          values.to_h[:eligibility_states]
            .each_pair do |eligibility_state_key, eligibility_state_val|
            result =
              AcaEntities::Eligibilities::Contracts::EligibilityStateContract.new
                .call(eligibility_state_val)
            next unless result.failure?

            key([*path, eligibility_state_key]).failure(
              { text: 'error', code: result.errors.to_h }
            )
          end
        end
      end
    end
  end
end
