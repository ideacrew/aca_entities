# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceStateContract < Dry::Validation::Contract
        params do
          optional(:evidence_gid).maybe(:string)
          required(:state).filled(
            :AcaEntities::Eligibilities::Types::EvidenceStateKind
          )
          optional(:is_satisfied).filled(:boolean)
          optional(:verification_outstanding).filled(:boolean)
          optional(:due_on).filled(:date)
          optional(:visted_at).filled(:date_time)
        end
      end
    end
  end
end
