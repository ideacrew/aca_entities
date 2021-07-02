# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SsfAttestationContract
      class SsfAttestationContract < Dry::Validation::Contract

        params do
          required(:non_perjury_indicator).filled(:bool)
          required(:not_incarcerated_indicator).filled(:bool)
          required(:information_changes_indicator).filled(:bool)
        end
      end
    end
  end
end
