# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for CurrentDeductionInformation.
    class CurrentDeductionInformationContract < Dry::Validation::Contract

      params do
        optional(:category_code).maybe(Types::DeductionCategoryCode)
        optional(:amount).maybe(:float)
        optional(:frequency_code).maybe(Iap::Types::DeductionFrequency)
        optional(:category_text).maybe(:string)
      end

      rule(:frequency_code) do
        key.failure(text: 'FrequencyCode is expected when Amount is not nil') if key? && !values[:amount].nil? && value.to_s.empty?
      end
    end
  end
end
