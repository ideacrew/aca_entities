# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class EvidenceStateContract < Dry::Validation::Contract
        params do
          optional(:evidence_gid).maybe(:string)
          required(:state).filled(AcaEntities::Eligibilities::Types::EvidenceStateKind)
          required(:is_satisfied).filled(:bool)
          required(:verification_outstanding).filled(:bool)
          required(:due_on).filled(:date)
          optional(:visted_at).filled(:date_time)
        end
      end
    end
  end
end
