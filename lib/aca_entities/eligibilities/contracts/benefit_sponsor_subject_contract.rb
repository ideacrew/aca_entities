# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for Benefit Sponsors subject
      class BenefitSponsorSubjectContract < Dry::Validation::Contract
        params do
          required(:fein).filled(:string)
          required(:legal_name).filled(:string)
          required(:benefit_sponsorship_id).filled(:string)
        end
      end
    end
  end
end
