# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SSATitleIIYearlyIncomeContract < Dry::Validation::Contract

          params do
            optional(:TitleIIRequestedYearInformation).maybe(AcaEntities::Fdsh::Ssa::H3::TitleIIRequestedYearInformationContract.params)
          end
        end
      end
    end
  end
end