# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      module Contracts
        # contract for { Subject }
        class SubjectContract < Dry::Validation::Contract
          params do
            # required(:gid).filled(type?: URI)
            required(:title).filled(:string)
            optional(:description).maybe(:hash)
            required(:key).filled(AcaEntities::Eligibilities::Types::SubjectType)
            required(:klass).filled(type?: URI)
            required(:eligibility_states).maybe(:hash)
            required(:outstanding_verification_status).filled(AcaEntities::Eligibilities::Types::DeterminationStateKind)
          end

          rule(:eligibility_states) do
            values.to_h[:eligibility_states]
                &.each_pair do |eligibility_state_key, eligibility_state_val|
              result =
                AcaEntities::Eligibilities::Contracts::EligibilityStateContract.new
                  .call(eligibility_state_val)
              next unless result.failure?

              key([*path, eligibility_state_key]).failure(
                { text: 'error', code: result.errors.to_h }
              )
            end
          end

          # rule(:subject) do
          #   if key? && value
          #     subject_type = values.to_h[:subject_type]
          #     if subject_type
          #       result = "AcaEntities::Eligibilities::Contracts::#{subject_type}Contract".constantize.new.call(value)
          #       key.failure(text: "invalid subject", error: result.errors.to_h) if result&.failure?
          #     end
          #   end
          # end
        end
      end
    end
  end
end
