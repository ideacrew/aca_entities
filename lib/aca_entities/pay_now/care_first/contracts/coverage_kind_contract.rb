# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Contracts
        # Contract for coverage_kind
        class CoverageKindContract < Dry::Validation::Contract

          params do
            required(:coverage_kind).filled(AcaEntities::PayNow::CareFirst::Types::PaynowCoverageKindType)
          end
        end
      end
    end
  end
end