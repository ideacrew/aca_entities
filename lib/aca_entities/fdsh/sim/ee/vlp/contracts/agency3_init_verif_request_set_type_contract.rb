# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp Agency3InitVerifRequestSetType
          class Agency3InitVerifRequestSetTypeContract < Dry::Validation::Contract

            params do
              required(:dhsid).filled(:string)
              required(:firstName).filled(:string)
              optional(:middleName).filled(:string)
              required(:lastName).filled(:string)
              required(:dateOfBirth).filled(:date)
              optional(:aka).maybe(:string)
              optional(:i94Number).maybe(:string)
              optional(:comments).maybe(:string)
              optional(:requestedCoverageStartDate).maybe(:date)
              optional(:fiveYearBarApplicabilityIndicator).maybe(:bool)
              optional(:requestSponsorDataIndicator).maybe(:bool)
              optional(:requestGrantDateIndicator).maybe(:bool)
              optional(:requesterCommentsForHub).maybe(:string)
              optional(:categoryCode).maybe(:string)
            end
          end
        end
      end
    end
  end
end