# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      module Contracts
        # Validation schema for BenefitSponsorshipOssePolicy
        class BenefitSponsorshipOssePolicyContract < Dry::Validation::Contract
          params do
            required(:value).filled(:string)
          end
        end
      end
    end
  end
end
