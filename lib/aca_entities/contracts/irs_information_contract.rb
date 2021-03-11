# frozen_string_literal: true

module AcaEntities
  module Contracts
    # contract for IrsInformation
    class IrsInformationContract < Dry::Validation::Contract

      params do
        optional(:total_exemptions).maybe(:integer)
        optional(:filing_status).maybe(:string)
        optional(:filing_year).maybe(:integer)
        optional(:magi_amount).maybe(:float)
        optional(:tin_identification).maybe(:integer)
        optional(:taxable_social_security_benefits).maybe(:float)
        optional(:agi_amount).maybe(:float)
      end
    end
  end
end
