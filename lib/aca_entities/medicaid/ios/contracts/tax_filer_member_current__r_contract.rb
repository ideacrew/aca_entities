# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for TaxFilerMemberCurrent__r
        class TaxFilerMemberCurrentRContract < Dry::Validation::Contract

          params do
            optional(:IndividualId__c).maybe(:integer)
            # TO DO: confirm if we should use this Id field instead
            # optional(:Id).maybe(:string)
          end
        end
      end
    end
  end
end