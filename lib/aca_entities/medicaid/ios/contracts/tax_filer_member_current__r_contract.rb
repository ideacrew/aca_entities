# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Contracts
        # Contract for TaxFilerMemberCurrent__r
        class TaxFilerMemberCurrentRContract < Dry::Validation::Contract

          params do
            optional(:IndividualId__c).maybe(:integer)
          end
        end
      end
    end
  end
end