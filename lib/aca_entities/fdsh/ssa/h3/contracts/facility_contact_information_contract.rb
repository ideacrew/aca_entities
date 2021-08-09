# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class FacilityContactInformationContract < Dry::Validation::Contract

          params do
            required(:PersonFullName).filled(:string)
            required(:ContactTelephoneNumber).filled(:string)
            required(:ContactFaxNumber).filled(:string)
          end
        end
      end
    end
  end
end