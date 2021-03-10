# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for DhsSave.
    class DhsSaveContract < Dry::Validation::Contract

      params do
        optional(:class_of_admission_code).maybe(Types::ClassOfAdmissionCode)
        optional(:admission_end_date).maybe(:date)
      end
    end
  end
end
