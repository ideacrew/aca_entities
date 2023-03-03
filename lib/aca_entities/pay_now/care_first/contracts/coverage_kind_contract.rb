# frozen_string_literal: true

module AcaEntities
    module PayNow
      module CareFirst
        module Contracts
          # Contract for NonEsiMecRequest
          class CoverageKindContract < Dry::Validation::Contract
  
            params do
              optional(:coverage_kind).filled(:string)
            end
          end
        end
      end
    end
  end