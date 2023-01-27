# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 RecipientContract
        class RecipientSpouseContract < Dry::Validation::Contract
          params do
            required(:OtherCompletePersonName).filled(AcaEntities::Fdsh::H41::Contracts::OtherCompletePersonNameContract.params)
            optional(:SSN).maybe(:string)
            optional(:BirthDt).maybe(:date)
          end
        end
      end
    end
  end
end