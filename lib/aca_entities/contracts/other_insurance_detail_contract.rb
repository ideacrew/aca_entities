# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for OtherInsuranceDetail.
    class OtherInsuranceDetailContract < Dry::Validation::Contract

      params do
        optional(:type_code).maybe(Types::OtherInsuranceTypeCode)
        optional(:insurance_name).maybe(:string)
        optional(:policy_number).maybe(:string)
      end
    end
  end
end
