# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceStateContract < Dry::Validation::Contract
        params do
          required(:evidence_gid).maybe(type?: URI)
          required(:status).filled(AcaEntities::Eligibilities::Types::EvidenceStateKind)
          required(:is_satisfied).filled(:bool)
          required(:verification_outstanding).filled(:bool)
          required(:due_on).maybe(:date)
          optional(:meta).maybe(:hash)
          required(:visited_at).filled(:date_time)
        end

        rule(:is_satisfied, :due_on) do
          key.failure('when is_satisfied is true, due_on must be nil') if values[:is_satisfied] && !values[:due_on].nil?
          key.failure('when is_satisfied is false, due_on must be present') if !values[:is_satisfied] && values[:due_on].nil?
        end
      end
    end
  end
end
