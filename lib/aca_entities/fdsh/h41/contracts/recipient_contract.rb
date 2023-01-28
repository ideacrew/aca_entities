# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 RecipientContract
        class RecipientContract < Dry::Validation::Contract
          params do
            required(:OtherCompletePersonName).filled(AcaEntities::Fdsh::H41::Contracts::OtherCompletePersonNameContract.params)
            optional(:SSN).maybe(:string)
            optional(:BirthDt).maybe(:date)
            required(:USAddressGrp).filled(AcaEntities::Fdsh::H41::Contracts::UsAddressGroupContract.params)
          end
        end
      end
    end
  end
end